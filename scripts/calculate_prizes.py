import json
import os
import sys
import time

from brownie import Contract

from dotenv import load_dotenv

from classes.draw_calculator import DrawCalculator
from classes.helper import Helper

def calculate_prizes_ethereum():
    print("Calculating prizes for the Ethereum depositors")
    calculate_prizes("ethereum")

def calculate_prizes_polygon():
    print("Calculating prizes for the Polygon depositors")
    calculate_prizes("polygon")

def calculate_prizes_avalanche():
    print("Calculating prizes for the Avalanche depositors")
    calculate_prizes("avalanche")

def calculate_prizes(network):
    start = time.perf_counter()

    # Read options file
    if not os.path.exists("options.json"):
        sys.stderr.write("Could not find options.json file!\n")
        sys.exit(1)
    options = json.loads(open("options.json").read())

    maximum_retries = options["config"]["maximum_retries"]

    load_dotenv()

    helper = Helper()

    # Fetch oldest and newest available draw id
    abi_buffer = json.loads(open("abis/DrawBufferAbi.json").read())
    draw_buffer_contract = Contract.from_abi("DrawBuffer", options["contracts"][network]["draw_buffer"], abi_buffer)

    _, oldest_draw, _, _, _ = draw_buffer_contract.getOldestDraw()
    _, newest_draw, _, _, _ = draw_buffer_contract.getNewestDraw()

    # If no draw ids were supplied, calculate all
    if options["config"]["draw_ids"] == []:
        draw_ids = [draw_id for draw_id in range(oldest_draw, newest_draw + 1)]
    # Otherwise calculate the specified ones
    else:
        draw_ids = options["config"]["draw_ids"]

    draws_dict = helper.find_draws_to_calculate(options["config"], draw_ids, network)
    draw_ids = sorted(list(draws_dict.keys()))
    draw_start_times = [draws_dict[draw_id]["beacon_period_started_at"] for draw_id in draw_ids]
    draw_stop_times = [draws_dict[draw_id]["timestamp"] for draw_id in draw_ids]

    # If we already calculated all draw ids, stop
    if draw_ids == []:
        return

    assert oldest_draw <= draw_ids[0], f"Cannot calculate prizes for a draw older than {oldest_draw}"
    assert newest_draw >= draw_ids[-1], f"Cannot calculate prizes for a draw younger than {newest_draw}"

    print(f"Calculating prizes for draws {', '.join(str(draw_id) for draw_id in draw_ids)}")

    all_accounts = set()
    for draw_id in draw_ids:
        if not os.path.exists(f"balances/holders_draw-{draw_id}.json"):
            sys.stderr.write(f"Could not find balances/holders_draw-{draw_id}.json file!\n")
            sys.exit(2)

        holders = json.loads(open(f"balances/holders_draw-{draw_id}.json").read())
        if network not in holders["balances"] or network not in holders["delegations"]:
            sys.stderr.write(f"Could not find {network} holders in balances/holders_draw-{draw_id}.json file!\n")
            sys.exit(3)
        accounts = list(holders["balances"][network].keys())
        accounts.extend(holders["delegations"][network])

        all_accounts.update(accounts)
    all_accounts = list(all_accounts)

    # Fetch prize distributions
    abi_prize_distribution_buffer = json.loads(open("abis/PrizeDistributionBufferAbi.json").read())
    prize_distribution_buffer_contract = Contract.from_abi("PrizeDistributionBuffer", options["contracts"][network]["prize_distribution_buffer"], abi_prize_distribution_buffer)

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
    draw_calculator_contract = Contract.from_abi("DrawCalculator", options["contracts"][network]["draw_calculator"], abi_calculator)

    normalized_balances_dict = {}
    for i, account in enumerate(all_accounts):
        print(f"Fetching normalized balances for account {account} ({i + 1} / {len(all_accounts)})")

        normalized_balances_dict[account] = {}

        retries = 0
        while True:
            try:
                normalized_balances = draw_calculator_contract.getNormalizedBalancesForDrawIds(account, draw_ids)
                break
            except ValueError:
                retries += 1
                if retries < maximum_retries:
                    print(f"Failed to fetch normalized balances for {account}, retrying in 5 seconds")
                    time.sleep(5)
                else:
                    print(f"Failed to fetch normalized balances for {account}, quitting after {maximum_retries} retries")

        for draw_id, normalized_balance in zip(draw_ids, normalized_balances):
            normalized_balances_dict[account][draw_id] = normalized_balance

    # Fetch average balances between draws
    abi_ticket = json.loads(open("abis/TicketAbi.json").read())
    ticket_contract = Contract.from_abi("Ticket", options["contracts"][network]["ticket"], abi_ticket)

    average_balances_dict = {}
    for i, account in enumerate(all_accounts):
        print(f"Fetching average balances for account {account} ({i + 1} / {len(all_accounts)})")

        average_balances_dict[account] = {}

        retries = 0
        while True:
            try:
                average_balances = ticket_contract.getAverageBalancesBetween(account, draw_start_times, draw_stop_times)
                break
            except ValueError:
                retries += 1
                if retries < maximum_retries:
                    print(f"Failed to fetch average balances for {account}, retrying in 5 seconds")
                    time.sleep(5)
                else:
                    print(f"Failed to fetch average balances for {account}, quitting after {maximum_retries} retries")

        for draw_id, average_balance in zip(draw_ids, average_balances):
            average_balances_dict[account][draw_id] = average_balance

    # Calculate picks and prizes
    draw_calculator = DrawCalculator(network)

    prizes_dict = {}
    for i, account in enumerate(all_accounts):
        print(f"Calculating picks for account {account} ({i + 1} / {len(all_accounts)})")

        prizes_dict[account] = []
        for draw_id in draw_ids:
            results = draw_calculator.calculate_draw_results(
                prize_distributions_dict[draw_id],
                draws_dict[draw_id],
                account,
                normalized_balances_dict[account][draw_id],
                average_balances_dict[account][draw_id],
            )
            prizes_dict[account].append(results)

    # Insert prize distributions in database
    helper.insert_prize_distributions(options["config"], network, prize_distributions_dict)
    # Insert prizes in database
    helper.insert_prizes(options["config"], network, prizes_dict)

    f = open(".draws_calculated", "a+")
    f.write(f"{network}: {', '.join(str(draw_id) for draw_id in draw_ids)}\n")
    f.close()

    print(f"Calculating prizes for {network} took {time.perf_counter() - start} seconds")
