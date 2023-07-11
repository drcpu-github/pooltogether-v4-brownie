import json
import psycopg2

from classes.database_manager import DatabaseManager

def fetch_prizes(db_mngr, address):
    sql = """
        SELECT
            network,
            draw_id,
            claimable_prizes,
            dropped_prizes
        FROM
            prizes
        WHERE
            address=%s
    """ % psycopg2.Binary(bytearray.fromhex(address[2:]))
    prizes = db_mngr.sql_return_all(sql)
    return [[prize[0], prize[1], prize[2], prize[3]] for prize in prizes]

def print_prizes(prizes):
    all_prizes = {}
    total_prize_value = 0
    for account, prizes in prizes.items():
        print(f"Account {account}")
        for prize in sorted(prizes, key=lambda l: l[1]):
            if prize[2]:
                print(f"\tDraw {prize[1]} on network {prize[0]}: {len(prize[2])} claimable prizes, total value: {round(sum(prize[2]) / 1E14)} USDC -- {len(prize[3])} dropped prizes, total value: {round(sum(prize[3]) / 1E14)} USDC", )

                total_prize_value += (sum(prize[2]) / 1E14)

                for claimable in prize[2]:
                    if claimable not in all_prizes:
                        all_prizes[claimable] = 0
                    all_prizes[claimable] += 1

    print("Claimable prize distribution:")
    for prize, amount in sorted(all_prizes.items()):
        print(f"\t{round(prize / 1E14, 2)} USDC: {amount}")

    print(f"Total prize amount: {total_prize_value} USDC")

def main():
    options = json.loads(open("options.json").read())

    db_mngr = DatabaseManager(options["config"]["user"], options["config"]["database"], options["config"]["password"])

    prizes = {}
    for address in options["config"]["addresses"]:
        prizes[address] = fetch_prizes(db_mngr, address)

    print_prizes(prizes)

if __name__ == "__main__":
    main()
