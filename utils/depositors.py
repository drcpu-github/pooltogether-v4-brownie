import calendar
import datetime
import json
import optparse
import os
import pickle
import subprocess
import sys
import time

from dotenv import load_dotenv
from web3 import Web3
from web3.middleware import geth_poa_middleware

from classes.database_manager import DatabaseManager
from classes.helper import Helper

def read_event_files(networks):
    events = {}
    for network in networks:
        events[network] = {}

        events[network]["claimeddraw"] = pickle.load(open(f"events/claimeddraw_{network}.bin", "rb"))
        events[network]["delegated"] = pickle.load(open(f"events/delegated_{network}.bin", "rb"))
        events[network]["deposit"] = pickle.load(open(f"events/deposited_{network}.bin", "rb"))
        events[network]["transfer"] = pickle.load(open(f"events/transfer_{network}.bin", "rb"))
        events[network]["withdrawal"] = pickle.load(open(f"events/withdrawal_{network}.bin", "rb"))

    return events

def setup_web3_providers():
    print("Setting up web3 providers")

    WEB3_ALCHEMY_ETHEREUM_PROJECT_ID = os.getenv("WEB3_ALCHEMY_ETHEREUM_PROJECT_ID")
    w3_ethereum = Web3(Web3.HTTPProvider(f"https://eth-mainnet.alchemyapi.io/v2/{WEB3_ALCHEMY_ETHEREUM_PROJECT_ID}"))

    WEB3_ALCHEMY_POLYGON_PROJECT_ID = os.getenv("WEB3_ALCHEMY_POLYGON_PROJECT_ID")
    w3_polygon = Web3(Web3.HTTPProvider(f"https://polygon-mainnet.g.alchemy.com/v2/{WEB3_ALCHEMY_POLYGON_PROJECT_ID}"))
    w3_polygon.middleware_onion.inject(geth_poa_middleware, layer=0)
    
    w3_optimism = Web3(Web3.HTTPProvider(f"https://opt-mainnet.g.alchemy.com/v2/{WEB3_ALCHEMY_POLYGON_PROJECT_ID}"))
    w3_optimism.middleware_onion.inject(geth_poa_middleware, layer=0)

    return {
        "ethereum": w3_ethereum, 
        "polygon": w3_polygon,
        "optimism": w3_optimism,
    }

def get_block_data(w3_provider, block_number=None):
    # Fetch current block
    if not block_number:
        block = w3_provider.eth.get_block("latest")
        block_number = block["number"]
    else:
        block = w3_provider.eth.get_block(block_number)

    return {
        "block_number": block_number,
        "block_timestamp": block["timestamp"],
    }

def get_blocks_for_draws(w3_provider, options, network):
    block_data = get_block_data(w3_provider)

    db_mngr = DatabaseManager(options["config"]["user"], options["config"]["database"], options["config"]["password"])

    sql = "SELECT draw_id, timestamp, block_number FROM draws WHERE network='%s' ORDER BY draw_id ASC" % network
    draws = db_mngr.sql_return_all(sql)

    draw_ids, block_numbers = [], []
    for draw_id, timestamp, block_number in draws:
        assert block_number != None
        draw_ids.append(draw_id)
        block_numbers.append(block_number)

    return draw_ids, block_numbers

def get_historical_balances(block_number, events, contracts, all_block_numbers=None):
    print(f"Processing events up to block {block_number}")

    warn_events_outdated = True

    previous_draw_block_number = block_number
    if all_block_numbers and all_block_numbers.index(block_number) > 0:
        previous_draw_block_number = all_block_numbers[all_block_numbers.index(block_number) - 1]

    balances = {}
    for deposit in events["deposit"]:
        if deposit["blockNumber"] > block_number:
            warn_events_outdated = False
            continue

        holder = deposit["args"]["to"]
        amount = deposit["args"]["amount"]

        # Ignore deposit to the PrizeDistributor contract
        if holder == contracts["prize_distributor"]:
            continue

        # Update balance
        if holder not in balances:
            # No information about previous draws, assume balance was updated during this draw
            if previous_draw_block_number == block_number:
                balances[holder] = [0, True]
            else:
                balances[holder] = [0, False]
        balances[holder][0] += amount

        # Were the balances updated during the current draw?
        if previous_draw_block_number != block_number and deposit["blockNumber"] > previous_draw_block_number:
            balances[holder][1] = True

    # Process claims
    for claimeddraw in events["claimeddraw"]:
        if claimeddraw["blockNumber"] > block_number:
            warn_events_outdated = False
            continue

        # Update balance
        claimee = claimeddraw["args"]["user"]
        payout = claimeddraw["args"]["payout"]

        if claimee not in balances:
            # No information about previous draws, assume balance was updated during this draw
            if previous_draw_block_number == block_number:
                balances[claimee] = [0, True]
            else:
                balances[claimee] = [0, False]
        balances[claimee][0] += payout

        # Were the balances updated during the current draw?
        if previous_draw_block_number != block_number and claimeddraw["blockNumber"] > previous_draw_block_number:
            balances[claimee][1] = True

    for transfer in events["transfer"]:
        if transfer["blockNumber"] > block_number:
            warn_events_outdated = False
            continue

        # Mint operation due to a deposit, ignore these
        if "from" in transfer["args"] and transfer["args"]["from"] == "0x0000000000000000000000000000000000000000":
            continue

        # Burn operation due to a whitdrawal, ignore these
        if "to" in transfer["args"] and transfer["args"]["to"] == "0x0000000000000000000000000000000000000000":
            continue

        # Claims, process these as separate events
        if "from" in transfer["args"] and transfer["args"]["from"] == contracts["prize_distributor"]:
            continue

        # Ignore transfers from the Reserve contract
        if "from" in transfer["args"] and transfer["args"]["from"] == contracts["reserve"]:
            continue

        # Ignore empty transfers
        # https://optimistic.etherscan.io/tx/0xda737f3fac9d6eaec69f9f9bfea00e9d975a8986d27b597c91aec24b82072989
        if transfer["args"]["value"] == 0:
            continue

        # Actual ticket transfers
        sender = transfer["args"]["from"]
        recipient = transfer["args"]["to"]
        value = transfer["args"]["value"]

        if recipient not in balances:
            # No information about previous draws, assume balance was updated during this draw
            if previous_draw_block_number == block_number:
                balances[recipient] = [0, True]
            else:
                balances[recipient] = [0, False]
        balances[recipient][0] += value
        balances[sender][0] -= value

        # Were the balances updated during the current draw?
        if previous_draw_block_number != block_number and transfer["blockNumber"] > previous_draw_block_number:
            balances[recipient][1] = True
            balances[sender][1] = True

    # Keep map of delegators to delegatees and watch for resets
    delegations = {}
    # Insert delegated addresses into the historical balance list, but don't increase their balance
    for delegate in events["delegated"]:
        if delegate["blockNumber"] > block_number:
            warn_events_outdated = False
            continue

        delegator = delegate["args"]["delegator"]
        delegatee = delegate["args"]["delegate"]

        if delegator != delegatee:
            delegations[delegator] = delegatee

    # Process withdraws
    for withdraw in events["withdrawal"]:
        if withdraw["blockNumber"] > block_number:
            warn_events_outdated = False
            continue

        # Update balances
        holder = withdraw["args"]["from"]
        amount = withdraw["args"]["amount"]

        if "executive_team" in contracts and holder == contracts["executive_team"]:
            continue

        balances[holder][0] -= amount

        # Were the balances updated during the current draw
        if previous_draw_block_number != block_number and withdraw["blockNumber"] > previous_draw_block_number:
            balances[holder][1] = True

    # Clean up holders that withdrew more than one draw ago
    eligible_balances = {}
    for holder in balances.keys():
        if balances[holder][0] != 0 or balances[holder][1] == True:
            eligible_balances[holder] = balances[holder][0]

    if len(balances) > len(eligible_balances):
        print(f"Reduced balance list from {len(balances)} addresses to {len(eligible_balances)} addresses")

    if warn_events_outdated:
        print(f"WARNING: No events found with a block number bigger than {block_number}, maybe the downloaded events are outdated!?")

    return eligible_balances, delegations

def main():
    parser = optparse.OptionParser()
    parser.add_option("--timestamp", type="string", dest="timestamp")
    parser.add_option("--draws", action="store_true", dest="draws")
    options, args = parser.parse_args()

    if (options.timestamp == None and options.draws == None) or (options.timestamp != None and options.draws != None):
        sys.stderr.write("Need either '--timestamp <YY-MM-DDTHH:MM:SS>' or '--draws' supplied on the command line")
        sys.exit(1)

    if not os.path.exists("balances"):
        os.mkdir("balances")

    load_dotenv()

    json_options = json.loads(open("options.json").read())
    networks = list(json_options["contracts"].keys())

    helper = Helper()

    w3_providers = {}
    for network in networks:
        w3_providers[network] = helper.setup_web3_provider(network)

    events = read_event_files(networks)

    # Get the block numbers for which the historical balances need to be built
    if options.timestamp:
        blocks_numbers = {}
        for network in networks:
            first_block_number = json_options["contracts"][network]["first_block_number"]
            block_number = helper.do_eth_block_request(network, options.timestamp)

        print(f"Creating historical balances for {options.timestamp}")

        # Create file name
        holders_file_name = f"holders_{options.timestamp.replace(':', '-')}.json"

        # If we already built that holder file, stop
        if not os.path.exists(os.path.join("balances", holders_file_name)):
            # Get historical balances and delegations for all networks
            balances = {"balances": {}, "delegations": {}}
            for network in networks:
                historical_balance, delegations = get_historical_balances(
                    blocks_numbers[network],
                    events[network],
                    options["contracts"][network],
                )
                balances["balances"][network] = historical_balance
                balances["balances"][network] = list(delegations.values())

            # Dump holders and delegatees
            json.dump(balances, open(os.path.join("balances", holders_file_name), "w+"))
    elif options.draws:
        balances = {}
        for network in networks:
            # Getting draw ids and blocks
            draw_ids, block_numbers = get_blocks_for_draws(w3_providers[network], json_options, network)

            calculated = False
            for draw_id, block_number in zip(draw_ids, block_numbers):
                # Create file name
                holders_file_name = f"holders_draw-{draw_id}.json"
                # If we already built that holder file, continue
                if os.path.exists(os.path.join("balances", holders_file_name)):
                    continue

                print(f"Creating historical balances for draw {draw_id} on network {network}")
                calculated = True

                if draw_id not in balances:
                    balances[draw_id] = {"balances": {}, "delegations": {}}

                # Get historical balances and delegations for ethereum and polygon
                historical_balance, delegations = get_historical_balances(
                    block_number,
                    events[network],
                    json_options["contracts"][network],
                    block_numbers
                )
                balances[draw_id]["balances"][network] = historical_balance
                balances[draw_id]["delegations"][network] = list(delegations.values())

            if calculated:
                print("")

        # Dump holders and delegatees
        for draw_id in balances.keys():
            json.dump(balances[draw_id], open(os.path.join("balances", f"holders_draw-{draw_id}.json"), "w+"))
    else:
        raise ValueError("Either a timestamp or draws should be specified!")

if __name__ == "__main__":
    main()
