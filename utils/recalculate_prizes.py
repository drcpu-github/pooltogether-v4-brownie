import json
import logging
import optparse
import sys

from classes.draw_calculator import DrawCalculator
from classes.helper import Helper

from utils.logger import setup_stdout_logger

def main():
    parser = optparse.OptionParser()
    parser.add_option("--draws", type="string", dest="draws", help="Comma-separated list of draw ids")
    parser.add_option("--networks", type="string", dest="networks", help="Comma-separated list of networks")
    options, args = parser.parse_args()

    if options.draws is None:
        print("Please pass a (comma-separated list of) draw ids")
        sys.exit(1)

    selected_draws = options.draws.split(",")

    if options.networks is None:
        print("Please pass a (comma-separated list of) networks")
        sys.exit(1)

    allowed_networks = ["ethereum", "polygon", "avalanche", "optimism"]
    selected_networks = options.networks.split(",")
    if set(selected_networks) - set(allowed_networks) != set():
        print(f"Unknown network requested: {selected_networks}")
        print(f"Allowed network are: {allowed_networks}")
        sys.exit(1)

    setup_stdout_logger()

    json_options = json.loads(open("options.json").read())

    helper = Helper()

    for draw in selected_draws:
        for network in selected_networks:
            prize_distribution_dict = helper.get_prize_distribution(json_options["config"], network, draw)
            draw_dict = helper.find_draws_to_calculate(json_options["config"], [int(draw)], network, recalculate=True)[int(draw)]
            account_balances = helper.get_account_balances(json_options["config"], network, draw)

            # Calculate picks and prizes
            draw_calculator = DrawCalculator(network)

            prizes_dict = {}
            for i, (account, normalized_balance, average_balance) in enumerate(account_balances):
                account = f"0x{account.hex()}"

                logging.info(f"Calculating picks for account {account} ({i + 1} / {len(account_balances)})")

                results = draw_calculator.calculate_draw_results(
                    prize_distribution_dict,
                    draw_dict,
                    account,
                    normalized_balance,
                    average_balance,
                )
                prizes_dict[account] = results

                if results["claimable_prizes"] != []:
                    print(results)

if __name__ == "__main__":
    main()
