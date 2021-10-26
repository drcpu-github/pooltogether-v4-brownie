import json
import time

from brownie import accounts, config, Contract

from draw_calculator.draw_calculator import DrawCalculator

def main():
    prizes = json.loads(open("prizes_polygon.json").read())
    options = json.loads(open("options_polygon.json").read())

    abi_prize_distributor = json.loads(open("abis/PrizeDistributorAbi.json").read())
    prize_distributor_contract = Contract.from_abi("PrizeDistributor", options["prize_distributor_address"], abi_prize_distributor)

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
