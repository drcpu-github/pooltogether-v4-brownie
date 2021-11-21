import json
import optparse

from classes.database_manager import DatabaseManager

def fetch_all_data(db_mngr):
    sql = """
        SELECT
            network,
            address,
            draw_id,
            claimable_prizes,
            normalized_balance
        FROM
            prizes
    """
    return db_mngr.sql_return_all(sql)

def find_small_frequent_winners(prizes, cutoff_percentage=10):
    draws = {}
    for prize in prizes:
        network, address, draw_id, claimable_prizes, normalized_balance = prize
        if draw_id not in draws:
            draws[draw_id] = []
        # Append all players with at least a non-zero deposit
        if normalized_balance > 0:
            draws[draw_id].append([network, address.hex(), claimable_prizes, normalized_balance])

    smallest_players, winners = {}, {}
    for draw_id in draws.keys():
        # Sort to find the smallest 10%
        smallest_players[draw_id] = sorted(draws[draw_id], key=lambda l: l[3])[:int(len(draws[draw_id]) / (100 / cutoff_percentage))]
        # Filter out the winners
        for player in smallest_players[draw_id]:
            if len(player[2]) > 0:
                if player[1] in winners:
                    winners[player[1]] += len(player[2])
                else:
                    winners[player[1]] = len(player[2])

    for winner, wins in winners.items():
        if wins > 1:
            print(winner, wins)
    print("")

def pretty_print(draws_claimable_prizes, draws_dropped_prizes):
    draw_ids = list(draws_claimable_prizes.keys())
    print (f"{'Draw':^8}|{'Claimable prizes':^20}|{'Dropped prizes':^18}|{'Total':^12}")
    print("--------+--------------------+------------------+----------")
    for draw_id in sorted(draw_ids):
        draw_claimable_prizes = round(draws_claimable_prizes[draw_id] / 1E14)
        draw_dropped_prizes = round(draws_dropped_prizes[draw_id] / 1E14)
        total_prizes = draw_claimable_prizes + draw_dropped_prizes
        print(f"{draw_id:^8}|{draw_claimable_prizes:^20}|{draw_dropped_prizes:^18}|{total_prizes:^12}")
    print("--------+--------------------+------------------+----------")
    total_claimable_prizes = round(sum(draws_claimable_prizes.values()) / 1E14)
    total_dropped_prizes = round(sum(draws_dropped_prizes.values()) / 1E14)
    total_prizes = total_claimable_prizes + total_dropped_prizes
    print(f"{'Total':^8}|{total_claimable_prizes:^20}|{total_dropped_prizes:^18}|{total_prizes:^12}")

def main():
    parser = optparse.OptionParser()
    parser.add_option("--options", type="string", dest="options")
    options, args = parser.parse_args()

    json_options = json.loads(open(options.options).read())

    db_mngr = DatabaseManager(json_options["config"]["user"], json_options["config"]["database"], json_options["config"]["password"])

    prizes = fetch_all_data(db_mngr)

    print("Find frequent winners in the bottom 10%:")
    frequent_winners = find_small_frequent_winners(prizes, cutoff_percentage=10)

    print("Find frequent winners in the bottom 20%:")
    frequent_winners = find_small_frequent_winners(prizes, cutoff_percentage=20)

    print("Find frequent winners in the bottom 30%:")
    frequent_winners = find_small_frequent_winners(prizes, cutoff_percentage=30)

    print("Find frequent winners in the bottom 40%:")
    frequent_winners = find_small_frequent_winners(prizes, cutoff_percentage=40)

    print("Find frequent winners in the bottom 50%:")
    frequent_winners = find_small_frequent_winners(prizes, cutoff_percentage=50)


if __name__ == "__main__":
    main()