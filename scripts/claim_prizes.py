import json
import sys
import time

from brownie import accounts, config, Contract, web3

from web3 import Web3

from classes.draw_calculator import DrawCalculator
from classes.helper import Helper

def claim_prizes_ethereum():
    print("Claiming prizes for the ethereum deposits")

    options = json.loads(open("options.json").read())

    claim_prizes(options, "ethereum")

def claim_prizes_polygon():
    print("Claiming prizes for the polygon deposits")

    options = json.loads(open("options.json").read())

    claim_prizes(options, "polygon")

def claim_prizes_avalanche():
    print("Claiming prizes for the avalanche deposits")

    options = json.loads(open("options.json").read())

    claim_prizes(options, "avalanche")

def claim_prizes(options, network):
    options = json.loads(open("options.json").read())

    # Fetch newest available draw id
    abi_buffer = json.loads(open("abis/DrawBufferAbi.json").read())
    draw_buffer_contract = Contract.from_abi("DrawBuffer", options["contracts"][network]["draw_buffer"], abi_buffer)

    _, newest_draw, _, _, _ = draw_buffer_contract.getNewestDraw()

    # Setup prize claim contract
    abi_prize_distributor = json.loads(open("abis/PrizeDistributorAbi.json").read())
    prize_distributor_contract = Contract.from_abi("PrizeDistributor", options["contracts"][network]["prize_distributor"], abi_prize_distributor)

    mock_prize_distributor_contract = web3.eth.contract(address = options["contracts"][network]["prize_distributor"], abi = abi_prize_distributor)

    draw_calculator = DrawCalculator(network)

    # Setup account to use for claiming prizes
    accounts.add(config["wallets"]["from_key"])
    claiming_account = accounts[0]
    claiming_account_str = f"{claiming_account}"
    print(f"Claiming prizes using account {claiming_account_str}")

    helper = Helper()

    for account in options["config"]["addresses"]:
        print(f"Claiming prizes for account {account}")

        # Fetch prizes from database for account and network
        draws = helper.get_prizes(options["config"], network, account)

        unclaimed_draws, unclaimed_draw_ids = [], []
        for draw in draws:
            # Cannot claim prizes for the newest draw due to the timelock
            if draw["draw_id"] == newest_draw:
                continue
            # Only need to prepare claims if the account won something
            if draw["total_value_claimable"] > 0:
                payed_out = prize_distributor_contract.getDrawPayoutBalanceOf(account, draw["draw_id"])
                if payed_out == 0:
                    # Apparently the DrawCalculator contract expects picks to be sorted from small to large
                    draw["claimable_prizes"] = sorted(draw["claimable_prizes"], key=lambda l: l["pick"])
                    unclaimed_draws.append(draw)
                    unclaimed_draw_ids.append(draw["draw_id"])
                else:
                    print(f"Already claimed prizes for draw id {draw['draw_id']} for account {account}")

        print(f"Creating claim for draws {unclaimed_draw_ids}")

        # Create claims
        claim = draw_calculator.prepare_claims(
            account,
            unclaimed_draws,
        )

        # Test claim transaction
        try:
            estimated_gas = mock_prize_distributor_contract.functions.claim(Web3.toChecksumAddress(account), unclaimed_draw_ids, claim["encoded_winning_pick_indices"]).estimateGas({"from": claiming_account_str})
        except ValueError as e:
            print(f"Will fail to claim for draws {unclaimed_draw_ids}: {e}")
            sys.exit(1)

        # Claim
        prize_distributor_contract.claim(
            account,
            unclaimed_draw_ids,
            claim["encoded_winning_pick_indices"],
            {"from": claiming_account}
        )
