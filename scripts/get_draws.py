import json
import os
import sys
import time

from brownie import Contract

from dotenv import load_dotenv

from eth_abi import encode_abi

from classes.database_manager import DatabaseManager
from classes.helper import Helper

def get_draws_ethereum():
    print("Getting draws for the Ethereum network")
    get_draws("ethereum")

def get_draws_polygon():
    print("Getting draws for the Polygon network")
    get_draws("polygon")

def get_draws_avalanche():
    print("Getting draws for the Avalanche network")
    get_draws("avalanche")

def get_draws(network):
    start = time.perf_counter()

    # Read options file
    if not os.path.exists("options.json"):
        sys.stderr.write("Could not find options.json file!\n")
        sys.exit(1)
    options = json.loads(open("options.json").read())

    load_dotenv()

    helper = Helper()

    w3_provider = helper.setup_web3_provider(network)

    # Fetch oldest and newest available draw id
    abi_buffer = json.loads(open("abis/DrawBufferAbi.json").read())
    draw_buffer_contract = Contract.from_abi("DrawBuffer", options["contracts"][network]["draw_buffer"], abi_buffer)

    _, oldest_draw, _, _, _ = draw_buffer_contract.getOldestDraw()
    _, newest_draw, _, _, _ = draw_buffer_contract.getNewestDraw()

    draw_ids = [draw_id for draw_id in range(oldest_draw, newest_draw + 1)]
    draw_ids = helper.find_draws_to_fetch(options["config"], draw_ids, network)

    # If we already have all draws, stop
    if draw_ids == []:
        return

    print(f"Fetching draw(s) {', '.join(str(draw_id) for draw_id in draw_ids)}")

    first_block_number = options["deploy_data"][network]["first_block_number"]

    # Fetch draw parameters
    draws = draw_buffer_contract.getDraws(draw_ids)

    draws_lst = []
    for draw in sorted(draws, key=lambda l: l[1]):
        winning_random_number, draw_id, timestamp, beacon_period_started_at, beacon_period_seconds = draw

        block_number = helper.do_eth_block_request(network, timestamp)

        draws_lst.append([
            draw_id,
            network,
            winning_random_number,
            timestamp,
            block_number,
            beacon_period_started_at,
            beacon_period_seconds,
        ])

    # Insert draws in database
    helper.insert_draws(options["config"], draws_lst)

    print(f"Getting draws for {network} took {time.perf_counter() - start} seconds")
