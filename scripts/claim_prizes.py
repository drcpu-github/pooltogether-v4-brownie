import json
import time

from brownie import accounts, config, Contract

from classes.draw_calculator import DrawCalculator

def claim_prizes_ethereum():
    print("Claiming prizes for the ethereum deposits")

    options = json.loads(open("options.json").read())

    claim_prizes(options, "ethereum")

def claim_prizes_polygon():
    print("Claiming prizes for the polygon deposits")

    options = json.loads(open("options.json").read())

    claim_prizes(options, "polygon")

def claim_prizes(options, network):
    options = json.loads(open("options.json").read())
    prizes = json.loads(open("prizes_to_claim.json").read())

    abi_prize_distributor = json.loads(open("abis/PrizeDistributorAbi.json").read())
    prize_distributor_contract = Contract.from_abi("PrizeDistributor", options["contracts"][network]["prize_distributor_address"], abi_prize_distributor)

    draw_calculator = DrawCalculator()

    accounts.add(config["wallets"]["from_key"])
    claiming_account = accounts[0]

    for account, draws in prizes.items():
        print(f"Claiming prizes for account {account}")

        unclaimed_draws, unclaimed_draw_ids = [], []
        for draw in draws:
            if draw["total_value_claimable"] > 0:
                payed_out = prize_distributor_contract.getDrawPayoutBalanceOf(account, draw["draw_id"])
                if payed_out == 0:
                    unclaimed_draws.append(draw)
                    unclaimed_draw_ids.append(draw["draw_id"])
                else:
                    print(f"Already claimed prizes for account {account}, draw id {draw['draw_id']}")

        claim = draw_calculator.prepare_claims(
            account,
            unclaimed_draws,
        )

        prize_distributor_contract.claim(
            account,
            unclaimed_draw_ids,
            claim["encoded_winning_pick_indices"],
            {"from": claiming_account}
        )
