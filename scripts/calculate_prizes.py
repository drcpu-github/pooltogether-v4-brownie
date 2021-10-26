import json
import time

from brownie import Contract

from draw_calculator.draw_calculator import DrawCalculator

def main():
    # options = json.loads(open("options_ethereum.json").read())
    options = json.loads(open("options_polygon.json").read())
    accounts = options["accounts"]
    draw_ids = options["draw_ids"]

    abi_buffer = json.loads(open("abis/DrawBufferAbi.json").read())
    draw_buffer_contract = Contract.from_abi("DrawBuffer", options["draw_buffer_address"], abi_buffer)

    _, oldest_draw, _, _, _ = draw_buffer_contract.getOldestDraw()
    _, newest_draw, _, _, _ = draw_buffer_contract.getNewestDraw()

    assert oldest_draw <= draw_ids[0], f"Cannot fetch a draw older than {oldest_draw}"
    assert newest_draw >= draw_ids[-1], f"Cannot fetch a draw younger than {newest_draw}"

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

    abi_prize_distribution_buffer = json.loads(open("abis/PrizeDistributionBufferAbi.json").read())
    prize_distribution_buffer_contract = Contract.from_abi("PrizeDistributionBuffer", options["prize_distribution_buffer_address"], abi_prize_distribution_buffer)

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

    abi_calculator = json.loads(open("abis/DrawCalculatorAbi.json").read())
    draw_calculator_contract = Contract.from_abi("DrawCalculator", options["draw_calculator_address"], abi_calculator)

    normalized_balances_dict = {}
    for account in accounts:
        print(f"Fetching balances for account {account}")

        normalized_balances_dict[account] = {}
        normalized_balances = draw_calculator_contract.getNormalizedBalancesForDrawIds(account, draw_ids)
        for draw_id, normalized_balance in zip(draw_ids, normalized_balances):
            normalized_balances_dict[account][draw_id] = normalized_balance

        time.sleep(1)

    draw_calculator = DrawCalculator()

    prizes = {}
    for account in accounts:
        print(f"Calculating picks for account {account}")

        prizes[account] = []
        for draw_id in draw_ids:
            results = draw_calculator.calculate_draw_results(
                prize_distributions_dict[draw_id],
                draws_dict[draw_id],
                account,
                normalized_balances_dict[account][draw_id],
            )
            prizes[account].append(results)

    # f = open("prizes_ethereum.json", "w+")
    f = open("prizes_polygon.json", "w+")
    json.dump(prizes, f)
    f.close()
