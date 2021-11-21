import json
import optparse

def print_prizes(prizes):
    all_prizes = {}
    total_prize_value = 0
    for account, prizes in prizes.items():
        print(f"Account {account}")
        for prize in prizes:
            print(f"\tDraw {prize['draw_id']}, number of claimable prizes: {len(prize['claimable_prizes'])}, total prize value: {round(prize['total_value_claimable'] / 1E6, 2)} USDC")

            total_prize_value += prize["total_value_claimable"]
            for claimable in prize['claimable_prizes']:
                if claimable["amount"] not in all_prizes:
                    all_prizes[claimable["amount"]] = 0
                all_prizes[claimable["amount"]] += 1

    print("Claimable prize distribution:")
    for prize, amount in sorted(all_prizes.items()):
        print(f"\t{round(prize / 1E6, 2)} USDC: {amount}")

    print(f"Total prize amount: {total_prize_value / 1E6} USDC")

def main():
    parser = optparse.OptionParser()
    parser.add_option("--json", type="string", dest="json")
    options, args = parser.parse_args()

    prizes = json.loads(open(options.json).read())
    print_prizes(prizes)

if __name__ == "__main__":
    main()
