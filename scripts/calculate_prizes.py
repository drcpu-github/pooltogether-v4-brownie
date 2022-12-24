import json
import logging
import os
import sys
import time

from multicall import Call, Multicall

from brownie import Contract

from dotenv import load_dotenv

from classes.draw_calculator import DrawCalculator
from classes.helper import Helper

from utils.logger import setup_stdout_logger

def calculate_prizes_ethereum():
    logging.info("Calculating prizes for the Ethereum depositors")
    calculate_prizes("ethereum")

def calculate_prizes_polygon():
    logging.info("Calculating prizes for the Polygon depositors")
    calculate_prizes("polygon")

def calculate_prizes_avalanche():
    logging.info("Calculating prizes for the Avalanche depositors")
    calculate_prizes("avalanche")

def calculate_prizes_optimism():
    logging.info("Calculating prizes for the Optimism depositors")
    calculate_prizes("optimism")

def calculate_prizes(network):
    start = time.perf_counter()

    setup_stdout_logger()

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

    logging.info(f"Calculating prizes for draws {', '.join(str(draw_id) for draw_id in draw_ids)}")

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

# Fetch normalized balances and average balances
    normalized_balances_dict = {}
    average_balances_dict = {}

    callsList = []
    if (network == "avalanche") : #Quick fix : need to use Alchemy Avalanche RPC
        batches = createBatches(all_accounts, 1) 
    else :
        batches = createBatches(all_accounts, 400) # NUMBER OF ADDRESSES BY BATCH
   
    total = 0
    for batch in batches:
        total += len(batch)
        logging.info(f"Batching addresses : {total} / {len(all_accounts)}")
        for i, account in enumerate(batch):
            normalized_balances_dict[account] = {}
            average_balances_dict[account] = {}
            callsList.append(Call(options["contracts"][network]["draw_calculator"], ['getNormalizedBalancesForDrawIds(address,uint32[])(uint256[])', account, draw_ids], [['normalizedBalance'+str(i), None]]))
            callsList.append(Call(options["contracts"][network]["ticket"], ['getAverageBalancesBetween(address,uint64[],uint64[])(uint256[])', account, draw_start_times, draw_stop_times], [['averageBalance'+str(i), None]]))
        retries = 0
        while retries < 5: 
            try:
                balances = Multicall(callsList)()
                break
            except Exception:        
                logging.info(f"Failed to fetch normalized and average balances for an account")
                retries += 1
                time.sleep(5)


        for i, account in enumerate(batch):        
            for draw_id, normalized_balance in zip(draw_ids, balances.get('normalizedBalance'+str(i))):
                normalized_balances_dict[account][draw_id] = normalized_balance

            for draw_id, average_balance in zip(draw_ids, balances.get('averageBalance'+str(i))):
                average_balances_dict[account][draw_id] = average_balance
        callsList.clear()

    # Calculate picks and prizes
    draw_calculator = DrawCalculator(network)

    prizes_dict = {}
    for i, account in enumerate(all_accounts):
        logging.info(f"Calculating picks for account {account} ({i + 1} / {len(all_accounts)})")

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

    logging.info(f"Calculating prizes for {network} took {time.perf_counter() - start} seconds")

def createBatches(list_a, chunk_size):
  for i in range(0, len(list_a), chunk_size):
    yield list_a[i:i + chunk_size]
       