import math
import os
import pickle
import sys

from web3 import Web3
from eth_abi import encode_abi

class DrawCalculator:
    def __init__(self, network):
        if not os.path.exists("picks"):
            os.mkdir("picks")

        self.network = network

    def calculate_number_of_picks_for_user(self, prize_distribution, normalized_balance):
        number_of_picks_for_draw = prize_distribution["number_of_picks"]
        return int(math.ceil(number_of_picks_for_draw * normalized_balance / Web3.toWei(1, "ether")))

    def compute_pick(self, address, pick):
        abi_encoded_value = encode_abi(["bytes32", "uint256"], [address, pick])
        user_random_number = Web3.solidityKeccak(["bytes32"], [abi_encoded_value])
        return {
            "index": pick,
            "hash": user_random_number
        }

    def generate_picks(self, prize_distribution, address, normalized_balance):
        checksum_address = Web3.toChecksumAddress(address)
        number_of_picks = self.calculate_number_of_picks_for_user(prize_distribution, normalized_balance)
        user_address_hashed = Web3.solidityKeccak(["address"], [checksum_address])

        if os.path.exists(f"picks/{self.network}_{address}.bin"):
            picks = pickle.load(open(f"picks/{self.network}_{address}.bin", "rb"))
        else:
            picks = []

        if number_of_picks != len(picks):
            if len(picks) < number_of_picks:
                for pick_index in range(len(picks), number_of_picks):
                    picks.append(self.compute_pick(user_address_hashed, pick_index))
                pickle.dump(picks, open(f"picks/{self.network}_{address}.bin", "wb+"))
            else:
                picks = picks[:number_of_picks]

        assert len(picks) == number_of_picks

        return picks

    def sanity_check_prize_distribution(self, prize_distribution):
        if prize_distribution["bit_range_size"] >= math.floor(256 / 10):
            sys.stderr.write("DrawCalculator/bit-range-size-too-large\n")
            sys.exit(1)
        else:
            total_sum = 0
            for i in range(0, len(prize_distribution["tiers"])):
                total_sum += prize_distribution["tiers"][i]

            if total_sum > Web3.toWei(1, "ether"):
                sys.stderr.write("DrawCalculator/tiers-greater-than-100%\n")
                sys.exit(2)

    def find_bit_matches_at_index(self, word1, word2, match_index, bit_range_size):
        index_offset = match_index * bit_range_size
        bit_range_max_int = 2 ** bit_range_size - 1

        mask = bit_range_max_int << index_offset
        bits1 = int(word1.hex(), 16) & mask
        bits2 = word2 & mask

        return bits1 == bits2

    def calculate_number_of_prizes_for_index(self, bit_range_size, tier_index):
        if tier_index > 0:
            return (1 << bit_range_size * tier_index) - (1 << bit_range_size * (tier_index - 1))
        else:
            return 1

    def calculate_fraction_of_prize(self, prize_distribution_index, prize_distribution):
        number_of_prizes = self.calculate_number_of_prizes_for_index(prize_distribution["bit_range_size"], prize_distribution_index)
        value_at_distribution_index = prize_distribution["tiers"][prize_distribution_index]
        fraction_of_prize = value_at_distribution_index * 1E9 / number_of_prizes
        return fraction_of_prize

    def calculate_prize_for_distribution_index(self, distribution_index, prize_distribution):
        fraction_of_prize = self.calculate_fraction_of_prize(distribution_index, prize_distribution)
        expected_prize_amount = prize_distribution["prize"] * fraction_of_prize / Web3.toWei(1, "ether")
        return expected_prize_amount

    def calculate_prize_amount(self, prize_distribution, matches):
        distribution_index = prize_distribution["match_cardinality"] - matches

        if distribution_index < len(prize_distribution["tiers"]):
            expected_prize_amount = self.calculate_prize_for_distribution_index(distribution_index, prize_distribution)
            return {
                "amount": expected_prize_amount,
                "distribution_index": distribution_index,
            }

        return None

    def calculate_pick_prize(self, random_number_this_pick, winning_random_number, prize_distribution):
        number_of_matches = 0
        for match_index in range(0, prize_distribution["match_cardinality"]):
            if not self.find_bit_matches_at_index(random_number_this_pick, winning_random_number, match_index, prize_distribution["bit_range_size"]):
                break
            number_of_matches += 1

        pick_amount = self.calculate_prize_amount(prize_distribution, number_of_matches)

        if pick_amount["amount"]:
            return pick_amount

        return None

    def compute_draw_results(self, prize_distribution, draw, picks):
        results = {
            "prizes": [],
            "total_value": 0,
            "draw_id": draw["draw_id"],
        }

        for pick in picks:
            pick_prize = self.calculate_pick_prize(pick["hash"], draw["winning_random_number"], prize_distribution)

            if pick_prize:
                pick_prize["pick"] = pick["index"]
                results["total_value"] += pick_prize["amount"]
                results["prizes"].append(pick_prize)

        return results

    def filter_results_by_value(self, draw_results, max_picks_per_user, normalized_balance, average_balance):
        sortedPrizes = sorted(draw_results["prizes"], key=lambda l: l["amount"], reverse=True)

        filtered_draw_results = {}
        filtered_draw_results["draw_id"] = draw_results["draw_id"]

        filtered_draw_results["claimable_prizes"] = sortedPrizes[:max_picks_per_user]
        filtered_draw_results["total_value_claimable"] = sum(prize["amount"] for prize in filtered_draw_results["claimable_prizes"])

        filtered_draw_results["dropped_prizes"] = sortedPrizes[max_picks_per_user:]
        filtered_draw_results["total_value_dropped"] = sum(prize["amount"] for prize in filtered_draw_results["dropped_prizes"])

        filtered_draw_results["normalized_balance"] = normalized_balance

        filtered_draw_results["average_balance"] = average_balance

        return filtered_draw_results

    def calculate_draw_results(self, prize_distribution, draw, address, normalized_balance, average_balance):
        self.sanity_check_prize_distribution(prize_distribution)

        picks = self.generate_picks(prize_distribution, address, normalized_balance)

        results = self.compute_draw_results(prize_distribution, draw, picks)
        results = self.filter_results_by_value(results, prize_distribution["max_picks_per_user"], normalized_balance, average_balance)

        return results

    def batch_calculate_draw_results(self, prize_distributions, draws, address, normalized_balances, average_balances):
        results = []
        for prize_distribution, draw, normalized_balance, average_balance in zip(prize_distributions, draws, normalized_balances, average_balances):
            draw_results = self.calculate_draw_results(prize_distribution, draw, address, normalized_balance, average_balance)
            results.append(draw_results)
        return results

    def prepare_claims(self, address, draw_results):
        claim = {
            "user_address": address,
            "draw_ids": [],
            "encoded_winning_pick_indices": "",
            "winning_pick_indices": []
        }

        if len(draw_results) == 0:
            return claim

        for draw_result in draw_results:
            if draw_result["total_value_claimable"] > 0:
                claim["draw_ids"].append(draw_result["draw_id"])

                winning_picks = []
                for prize in draw_result["claimable_prizes"]:
                    winning_picks.append(prize["pick"])
                claim["winning_pick_indices"].append(winning_picks)

        claim["encoded_winning_pick_indices"] = encode_abi(["uint256[][]"], [claim["winning_pick_indices"]]).hex()

        return claim
