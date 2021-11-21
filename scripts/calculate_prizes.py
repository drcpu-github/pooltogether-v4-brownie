import json
import os
import sys
import time

from brownie import Contract

from classes.database_manager import DatabaseManager
from classes.draw_calculator import DrawCalculator
from classes.helper import Helper

def check_and_read_required_files():
    if not os.path.exists("options.json"):
        sys.stderr.write("Could not find options.json file!\n")
        sys.exit(1)

    options = json.loads(open("options.json").read())

    if not os.path.exists(options["config"]["holders"]):
        sys.stderr.write("Could not find holders.json file!\n")
        sys.exit(2)

    accounts = json.loads(open(options["config"]["holders"]).read())

    return options, accounts

def calculate_prizes_ethereum():
    print("Calculating prizes for the ethereum depositors")

    options, accounts = check_and_read_required_files()
    if "ethereum" not in accounts:
        sys.stderr.write("Could not find ethereum holders in holders.json file!\n")
        sys.exit(3)
    accounts = accounts["ethereum"].keys()

    calculate_prizes(accounts, "ethereum", options)

def calculate_prizes_polygon():
    print("Calculating prizes for the polygon depositors")

    options, accounts = check_and_read_required_files()
    if "polygon" not in accounts:
        sys.stderr.write("Could not find polygon holders in holders.json file!\n")
        sys.exit(3)
    accounts = accounts["polygon"].keys()

    calculate_prizes(accounts, "polygon", options)

def calculate_prizes(accounts, network, options):
    # Fetch oldest and newest available draw id
    abi_buffer = json.loads(open("abis/DrawBufferAbi.json").read())
    draw_buffer_contract = Contract.from_abi("DrawBuffer", options["contracts"][network]["draw_buffer_address"], abi_buffer)

    _, oldest_draw, _, _, _ = draw_buffer_contract.getOldestDraw()
    _, newest_draw, _, _, _ = draw_buffer_contract.getNewestDraw()

    # If no draw ids were supplied, calculate all
    if options["config"]["draw_ids"] == []:
        draw_ids = [draw_id for draw_id in range(oldest_draw, newest_draw + 1)]
    # Otherwise calculate the specified ones
    else:
        draw_ids = options["config"]["draw_ids"]
        assert oldest_draw <= draw_ids[0], f"Cannot fetch a draw older than {oldest_draw}"
        assert newest_draw >= draw_ids[-1], f"Cannot fetch a draw younger than {newest_draw}"

    helper = Helper()
    draw_ids = helper.find_draws_to_calculate(options["config"], draw_ids, network)

    # If we already calculated all draw ids, stop
    if draw_ids == []:
        return

    print(f"Calculating prizes for draws {', '.join(str(draw_id) for draw_id in draw_ids)}")

    # Fetch draw parameters
    draws_dict = {}
    draws = draw_buffer_contract.getDraws(draw_ids)
    for draw in draws:
        winning_random_number, draw_id, timestamp, beacon_period_started_at, beacon_period_seconds = draw
        draws_dict[draw_id] = {
            "winning_random_number": winning_random_number,
            "draw_id": draw_id,
            "timestamp": timestamp,
            "beacon_period_started_at": beacon_period_started_at,
            "beacon_period_seconds": beacon_period_seconds,
        }

    # Fetch prize distributions
    abi_prize_distribution_buffer = json.loads(open("abis/PrizeDistributionBufferAbi.json").read())
    prize_distribution_buffer_contract = Contract.from_abi("PrizeDistributionBuffer", options["contracts"][network]["prize_distribution_buffer_address"], abi_prize_distribution_buffer)

    prize_distributions_dict = {}
    prize_distributions = prize_distribution_buffer_contract.getPrizeDistributions(draw_ids)
    for draw_id, prize_distribution in zip(draw_ids, prize_distributions):
        bit_range_size, match_cardinality, start_timestamp_offset, end_timestamp_offset, max_picks_per_user, expiry_duration, number_of_picks, tiers, prize = prize_distribution
        prize_distributions_dict[draw_id] = {
            "bit_range_size": bit_range_size,
            "match_cardinality": match_cardinality,
            "start_timestamp_offset": start_timestamp_offset,
            "end_timestamp_offset": end_timestamp_offset,
            "max_picks_per_user": max_picks_per_user,
            "expiry_duration": expiry_duration,
            "number_of_picks": number_of_picks,
            "tiers": tiers,
            "prize": prize,
        }

    # Fetch normalized balances
    abi_calculator = json.loads(open("abis/DrawCalculatorAbi.json").read())
    draw_calculator_contract = Contract.from_abi("DrawCalculator", options["contracts"][network]["draw_calculator_address"], abi_calculator)

    normalized_balances_dict = {}
    for i, account in enumerate(accounts):
        print(f"Fetching normalized balances for account {account} ({i + 1} / {len(accounts)})")

        normalized_balances_dict[account] = {}
        normalized_balances = draw_calculator_contract.getNormalizedBalancesForDrawIds(account, draw_ids)
        for draw_id, normalized_balance in zip(draw_ids, normalized_balances):
            normalized_balances_dict[account][draw_id] = normalized_balance

    # Calculate picks and prizes
    draw_calculator = DrawCalculator()

    prizes_dict = {}
    for i, account in enumerate(accounts):
        print(f"Calculating picks for account {account} ({i + 1} / {len(accounts)})")

        prizes_dict[account] = []
        for draw_id in draw_ids:
            results = draw_calculator.calculate_draw_results(
                prize_distributions_dict[draw_id],
                draws_dict[draw_id],
                account,
                normalized_balances_dict[account][draw_id],
            )
            prizes_dict[account].append(results)

    # Insert draws in database
    helper.insert_draws(options["config"], network, draws_dict)
    # Insert prize distributions in database
    helper.insert_prize_distributions(options["config"], network, prize_distributions_dict)
    # Insert prizes in database
    helper.insert_prizes(options["config"], network, prizes_dict)
