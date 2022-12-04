import json
import logging
import os
import requests

import urllib.parse

from web3 import Web3
from web3.middleware import geth_poa_middleware

from classes.database_manager import DatabaseManager

class Helper:
    def insert_draws(self, options, draws):
        logging.info("Saving draws to database")

        sql = """
            INSERT INTO draws (
                draw_id,
                network,
                winning_random_number,
                timestamp,
                block_number,
                beacon_period_started_at,
                beacon_period_seconds
            ) VALUES %s
        """

        db_mngr = DatabaseManager(options["user"], options["database"], options["password"])
        db_mngr.sql_execute_many(sql, draws)
        db_mngr.terminate(verbose=False)

    def insert_prize_distributions(self, options, network, prize_distributions_dict):
        logging.info("Saving prize distributions to database")

        prize_distributions = []
        for draw_id, prize_distribution in prize_distributions_dict.items():
            prize_distributions.append([
                draw_id,
                network,
                prize_distribution["bit_range_size"],
                prize_distribution["match_cardinality"],
                prize_distribution["start_timestamp_offset"],
                prize_distribution["end_timestamp_offset"],
                prize_distribution["max_picks_per_user"],
                prize_distribution["expiry_duration"],
                prize_distribution["number_of_picks"],
                [tier for tier in prize_distribution["tiers"]],
                prize_distribution["prize"],
            ])
        sql = """
            INSERT INTO prize_distributions (
                draw_id,
                network,
                bit_range_size,
                match_cardinality,
                start_timestamp_offset,
                end_timestamp_offset,
                max_picks_per_user,
                expiry_duration,
                number_of_picks,
                tiers,
                prize
            ) VALUES %s
        """

        db_mngr = DatabaseManager(options["user"], options["database"], options["password"])
        db_mngr.sql_execute_many(sql, prize_distributions)
        db_mngr.terminate(verbose=False)

    def insert_prizes(self, options, network, prizes_dict):
        logging.info("Saving prizes to database")

        sql_prizes = []
        for user, prizes in prizes_dict.items():
            for prize in sorted(prizes, key=lambda l: l["draw_id"]):
                sql_prizes.append([
                    network,
                    bytearray.fromhex(user[2:]),
                    prize["draw_id"],
                    [int(prize["amount"] * 1E8) for prize in prize["claimable_prizes"]],
                    [prize["pick"] for prize in prize["claimable_prizes"]],
                    [int(prize["amount"] * 1E8) for prize in prize["dropped_prizes"]],
                    [prize["pick"] for prize in prize["dropped_prizes"]],
                    prize["normalized_balance"],
                    prize["average_balance"],
                ])
        sql = """
            INSERT INTO prizes (
                network,
                address,
                draw_id,
                claimable_prizes,
                claimable_picks,
                dropped_prizes,
                dropped_picks,
                normalized_balance,
                average_balance
            ) VALUES %s
        """

        db_mngr = DatabaseManager(options["user"], options["database"], options["password"])
        db_mngr.sql_execute_many(sql, sql_prizes)
        db_mngr.terminate(verbose=False)

    def get_prizes(self, options, network, address):
        logging.info("Fetching prizes from database")

        sql = """
            SELECT network, address, draw_id, claimable_prizes, claimable_picks
            FROM
                prizes
            WHERE
                network='%s'
            AND
                address='\\x%s'
        """ % (network, address[2:])

        db_mngr = DatabaseManager(options["user"], options["database"], options["password"])
        prizes = db_mngr.sql_return_all(sql)
        db_mngr.terminate(verbose=False)

        draw_prizes = []
        for prize in prizes:
            draw_prizes.append({
                "total_value_claimable": sum(prize[3]),
                "draw_id": prize[2],
                "claimable_prizes": [{"value": value, "pick": pick} for value, pick in zip(prize[3], prize[4])],
            })

        return draw_prizes

    def setup_web3_provider(self, network):
        logging.info("Setting up web3 provider")

        if network == "ethereum":
            WEB3_ETHEREUM_ALCHEMY = os.getenv("WEB3_ETHEREUM_ALCHEMY")
            w3_provider = Web3(Web3.HTTPProvider(f"https://eth-mainnet.alchemyapi.io/v2/{WEB3_ETHEREUM_ALCHEMY}"))
        elif network == "polygon":
            WEB3_POLYGON_ALCHEMY = os.getenv("WEB3_POLYGON_ALCHEMY")
            w3_provider = Web3(Web3.HTTPProvider(f"https://polygon-mainnet.g.alchemy.com/v2/{WEB3_POLYGON_ALCHEMY}"))
            w3_provider.middleware_onion.inject(geth_poa_middleware, layer=0)
        elif network == "avalanche":
            w3_provider = Web3(Web3.HTTPProvider(f"https://api.avax.network/ext/bc/C/rpc"))
            w3_provider.middleware_onion.inject(geth_poa_middleware, layer=0)
        elif network == "optimism":
            WEB3_OPTIMISM_ALCHEMY = os.getenv("WEB3_OPTIMISM_ALCHEMY")
            w3_provider = Web3(Web3.HTTPProvider(f"https://opt-mainnet.g.alchemy.com/v2/{WEB3_OPTIMISM_ALCHEMY}"))
            w3_provider.middleware_onion.inject(geth_poa_middleware, layer=0)
        return w3_provider

    def fetch_draw_ids(self, network, draw_buffer_address):
        if network in ("ethereum", "polygon", "avalanche"):
            from brownie import Contract

            # Fetch oldest and newest available draw id
            abi_buffer = json.loads(open("abis/DrawBufferAbi.json").read())
            draw_buffer_contract = Contract.from_abi("DrawBuffer", draw_buffer_address, abi_buffer)

            _, oldest_draw, _, _, _ = draw_buffer_contract.getOldestDraw()
            _, newest_draw, _, _, _ = draw_buffer_contract.getNewestDraw()
        else:
            abi_buffer = json.loads(open("abis/DrawBufferAbi.json").read())
            for function in abi_buffer:
                if function["type"] == "function" and function["name"] == "getOldestDraw":
                    get_oldest_draw = self.calculate_function_selector(function["name"], function["inputs"])
                    _, oldest_draw, _, _, _ = self.do_eth_call_request(network, draw_buffer_address, get_oldest_draw)
                    oldest_draw = int(oldest_draw, 16)
                elif function["type"] == "function" and function["name"] == "getNewestDraw":
                    get_newest_draw = self.calculate_function_selector(function["name"], function["inputs"])
                    _, newest_draw, _, _, _ = self.do_eth_call_request(network, draw_buffer_address, get_newest_draw)
                    newest_draw = int(newest_draw, 16)
        
        return oldest_draw, newest_draw

    def find_draws_to_fetch(self, options, draw_ids, network):
        draw_ids_to_fetch = draw_ids

        # First check the draw ids for which we already fetched data
        db_mngr = DatabaseManager(options["user"], options["database"], options["password"])
        sql = """
            SELECT
                DISTINCT draw_id
            FROM draws
            WHERE
                network='%s'
        """ % network
        draws_already_fetched = [draw[0] for draw in db_mngr.sql_return_all(sql)]
        draw_ids_to_fetch = list(set(draw_ids_to_fetch) - set(draws_already_fetched))
        db_mngr.terminate(verbose=False)

        return draw_ids_to_fetch

    def find_draws_to_calculate(self, options, draw_ids, network):
        draw_ids_to_calculate = draw_ids

        # First check the draw ids for which we already calculated prizes
        db_mngr = DatabaseManager(options["user"], options["database"], options["password"])
        sql = """
            SELECT
                DISTINCT draw_id
            FROM prizes
            WHERE
                network='%s'
        """ % network
        prizes = db_mngr.sql_return_all(sql)
        draws_already_calculated = [prize[0] for prize in prizes]
        draw_ids_to_calculate = list(set(draw_ids_to_calculate) - set(draws_already_calculated))

        sql = """
            SELECT
                draw_id,
                network,
                winning_random_number,
                timestamp,
                block_number,
                beacon_period_started_at,
                beacon_period_seconds
            FROM draws
            WHERE
                network='%s'
        """ % network
        draws = db_mngr.sql_return_all(sql)

        draws_to_calculate = {}
        for draw in draws:
            if draw[0] in draw_ids_to_calculate:
                draws_to_calculate[draw[0]] = {
                    "draw_id": draw[0],
                    "network": draw[1],
                    "winning_random_number": int(str(draw[2])),
                    "timestamp": draw[3],
                    "block_number": draw[4],
                    "beacon_period_started_at": draw[5],
                    "beacon_period_seconds": draw[6],
                }

        db_mngr.terminate(verbose=False)

        return draws_to_calculate

    def get_base_url_and_key(self, network):
        if network == "avalanche":
            base_url = "https://api.snowtrace.io/api"
            api_key = os.getenv("SNOWTRACE_API_KEY")
        elif network == "polygon":
            base_url = "https://api.polygonscan.com/api"
            api_key = os.getenv("POLYGONSCAN_API_KEY")
        elif network == "ethereum":
            base_url = "https://api.etherscan.io/api"
            api_key = os.getenv("ETHERSCAN_API_KEY")
        elif network == "optimism":
            base_url = "https://api-optimistic.etherscan.io/api"
            api_key = os.getenv("OPTIMISM_API_KEY")
        else:
            raise ValueError("Unknown network")
        return base_url, api_key

    def do_eth_call_request(self, network, address, data):
        base_url, api_key = self.get_base_url_and_key(network)
        url = base_url + "?" + urllib.parse.urlencode({
            "module": "proxy",
            "action": "eth_call",
            "to": address,
            "data": data,
            "tag": "latest",
            "apikey": api_key
        })
        message = requests.get(url)
        if message.status_code == 200:
            return self.decode_response(json.loads(message.text)["result"])
        else:
            raise ValueError(message.status_code)

    def do_eth_block_request(self, network, timestamp):
        base_url, api_key = self.get_base_url_and_key(network)
        url = base_url + "?" + urllib.parse.urlencode({
            "module": "block",
            "action": "getblocknobytime",
            "timestamp": timestamp,
            "closest": "before",
            "apikey": api_key
        })
        message = requests.get(url)
        if message.status_code == 200:
            return json.loads(message.text)["result"]
        else:
            raise ValueError(message.status_code)

    def decode_response(self, response):
        return [response[i : i + 64] for i in range(2, len(response), 64)]

    def calculate_function_selector(self, function, inputs):
        encoded_inputs = ",".join([inp["type"] for inp in inputs])
        return Web3.keccak(text=f"{function}({encoded_inputs})")[:4].hex()

    def get_block_data(self, w3_provider, block_number=None):
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

    def binary_search_block_at_time(self, w3_provider, start_block_number, unixtime):
        logging.info(f"Binary searching blockchain for timestamp {unixtime}")

        # Stop block
        stop_block_data = get_block_data(w3_provider)
        stop_block_number = stop_block_data["block_number"]
        stop_block_time = stop_block_data["block_timestamp"]

        # Start block
        start_block_data = get_block_data(w3_provider, block_number=start_block_number)
        start_block_time = start_block_data["block_timestamp"]

        if unixtime > stop_block_time:
            return stop_block_number
        elif unixtime < start_block_time:
            return start_block_number
        else:
            while True:
                # Pivot to the middle of the range
                pivot = int((start_block_number + stop_block_number) / 2)
                pivot_block_data = get_block_data(w3_provider, block_number=pivot)
                # Update end boundary to pivot
                if pivot_block_data["block_timestamp"] < unixtime:
                    start_block_number = pivot
                # Update start boundary to pivot
                elif pivot_block_data["block_timestamp"] > unixtime:
                    stop_block_number = pivot
                # Matching time found
                else:
                    return pivot
                # Special end condition for when there is no exact timestamp match
                if start_block_number + 1 == stop_block_number:
                    stop_block_data = get_block_data(w3_provider, block_number=stop_block_number)
                    if stop_block_data["block_timestamp"] <= unixtime:
                        return stop_block_number
                    else:
                        return start_block_number
