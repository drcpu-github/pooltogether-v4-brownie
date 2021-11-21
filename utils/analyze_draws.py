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
            claimable_picks,
            dropped_prizes,
            dropped_picks
        FROM
            prizes
    """
    return db_mngr.sql_return_all(sql)

def accumulate_per_draw(prizes):
    prize_amounts = set()
    draws_claimable_prizes, draws_claimable_prizes_amount = {}, {}
    draws_dropped_prizes, draws_dropped_prizes_amount, draws_dropped_addresses = {}, {}, {}
    for prize in prizes:
        network, address, draw_id, claimable_prizes, claimable_picks, dropped_prizes, dropped_picks = prize

        # Initialize claimable prizes dictionaries
        if draw_id not in draws_claimable_prizes_amount:
            draws_claimable_prizes[draw_id] = {}
            draws_claimable_prizes_amount[draw_id] = 0
        # Sum claimable prizes per prize category
        for claimable_prize in claimable_prizes:
            prize_amounts.add(claimable_prize)
            if claimable_prize not in draws_claimable_prizes[draw_id]:
                draws_claimable_prizes[draw_id][claimable_prize] = 0
            draws_claimable_prizes[draw_id][claimable_prize] += 1
        # Sum all claimable prizes to a single value
        draws_claimable_prizes_amount[draw_id] += sum(claimable_prizes)

        # Initialize dropped prizes dictionaries
        if draw_id not in draws_dropped_prizes:
            draws_dropped_prizes[draw_id] = {}
            draws_dropped_prizes_amount[draw_id] = 0
            draws_dropped_addresses[draw_id] = 0
        # Sum dropped prizes per prize category
        for dropped_prize in dropped_prizes:
            prize_amounts.add(dropped_prize)
            if dropped_prize not in draws_dropped_prizes[draw_id]:
                draws_dropped_prizes[draw_id][dropped_prize] = 0
            draws_dropped_prizes[draw_id][dropped_prize] += 1
        # Sum all dropped prizes to a single value
        draws_dropped_prizes_amount[draw_id] += sum(dropped_prizes)
        if sum(dropped_prizes) > 0:
            draws_dropped_addresses[draw_id] += 1

    return prize_amounts, draws_claimable_prizes, draws_claimable_prizes_amount, draws_dropped_prizes, draws_dropped_prizes_amount, draws_dropped_addresses

def unique_winners_per_draw(prizes):
    winners_per_draw = {}
    unique_winners = set()
    for prize in prizes:
        network, address, draw_id, claimable_prizes, claimable_picks, dropped_prizes, dropped_picks = prize
        if draw_id not in winners_per_draw:
            winners_per_draw[draw_id] = set()
        if sum(claimable_prizes) > 0:
            # Unique winners over all draws
            unique_winners.add(address)
            # Unique winners per draw
            winners_per_draw[draw_id].add(address)

    # Get amount of unique winners per draw
    for draw_id in winners_per_draw.keys():
        winners_per_draw[draw_id] = len(winners_per_draw[draw_id])

    return winners_per_draw, len(unique_winners)

def print_amount_data(draws_claimable_prizes_amount, draws_dropped_prizes_amount, draws_dropped_addresses, winners_per_draw, unique_winners):
    f = open("data/draw_amounts.csv", "w+")

    draw_ids = list(draws_claimable_prizes_amount.keys())

    # Print amount statistics per draw
    f.write("Draw,Claimable prize amount,Dropped prize amount,Dropped users,Total amount,Winners\n")
    print(f"{'Draw':^8}|{'Claimable prize amount':^25}|{'Dropped prize amount':^25}|{'Dropped users':^16}|{'Total amount':^16}|{'Winners':^12}")
    print("--------+-------------------------+-------------------------+----------------+----------------+----------")
    for draw_id in sorted(draw_ids):
        # Round claimable prizes amount to USDC
        draw_claimable_prizes_amount = round(draws_claimable_prizes_amount[draw_id] / 1E14)
        # Round dropped prizes amount to USDC
        draw_dropped_prizes_amount = round(draws_dropped_prizes_amount[draw_id] / 1E14)
        # Sum prizes amount to USDC
        total_prizes_amount = draw_claimable_prizes_amount + draw_dropped_prizes_amount
        # Fetch dropped addresses
        dropped_users = draws_dropped_addresses[draw_id]
        # Fetch unique winners
        winners = winners_per_draw[draw_id]
        f.write(f"{draw_id},{draw_claimable_prizes_amount},{draw_dropped_prizes_amount},{dropped_users},{total_prizes_amount},{winners}\n")
        print(f"{draw_id:^8}|{draw_claimable_prizes_amount:^25}|{draw_dropped_prizes_amount:^25}|{dropped_users:^16}|{total_prizes_amount:^16}|{winners:^12}")
    print("--------+-------------------------+-------------------------+----------------+----------------+----------")

    # Round claimable prizes amount to USDC
    total_claimable_prizes_amount = round(sum(draws_claimable_prizes_amount.values()) / 1E14)
    # Round dropped prizes amount to USDC
    total_dropped_prizes_amount = round(sum(draws_dropped_prizes_amount.values()) / 1E14)
    # Sum prizes amount to USDC
    total_prizes_amount = total_claimable_prizes_amount + total_dropped_prizes_amount
    # Sum dropped addresses
    total_dropped_users = sum(draws_dropped_addresses.values())
    f.write(f"total,{total_claimable_prizes_amount},{total_dropped_prizes_amount},{total_dropped_users},{total_prizes_amount},{unique_winners}\n")
    print(f"{'Total':^8}|{total_claimable_prizes_amount:^25}|{total_dropped_prizes_amount:^25}|{total_dropped_users:^16}|{total_prizes_amount:^16}|{unique_winners:^12}")

    f.write("\n")
    print("")

    f.close()

def print_per_prize_data(prize_amounts, prizes, key):
    f = open(f"data/draw_prizes_{key}.csv", "w+")

    draw_ids = list(prizes.keys())

    # Sorted prize amounts as a dollar value
    dollar_prizes = sorted(list(set([round(prize_amount / 1E14) for prize_amount in prize_amounts])))

    # Setup header for 'key' prizes
    f.write("Draw")
    print(f"{'Draw':^8}", end="")
    for dollar in dollar_prizes:
        f.write(f"{',$' + str(dollar) + ' ' + key}")
        print(f"|{'$' + str(dollar) + ' ' + key:^20}", end="")
    print("\n--------+", end="")
    for dollar in dollar_prizes:
        print("--------------------+", end="")
    f.write("\n")
    print("")

    # Print 'key' prizes per draw
    accumulated_prizes = {dollar_prize: 0 for dollar_prize in dollar_prizes}
    for draw_id in sorted(draw_ids):
        per_draw = prizes[draw_id]

        accumulated_per_draw = {dollar_prize: 0 for dollar_prize in dollar_prizes}
        for value, amount in per_draw.items():
            dollar_value = round(value / 1E14)
            accumulated_prizes[dollar_value] += amount
            accumulated_per_draw[dollar_value] += amount

        f.write(f"{draw_id}")
        print(f"{draw_id:^8}", end="")
        for dollar_value in sorted(accumulated_per_draw.keys()):
            f.write(f",{accumulated_per_draw[dollar_value]}")
            print(f"|{accumulated_per_draw[dollar_value]:^20}", end="")
        f.write("\n")
        print("")

    print("--------+", end="")
    for dollar in dollar_prizes:
        print("--------------------+", end="")
    f.write("Total")
    print(f"\n{'Total':^8}", end="")
    for dollar_value in sorted(accumulated_prizes.keys()):
        f.write(f",{accumulated_prizes[dollar_value]}")
        print(f"|{accumulated_prizes[dollar_value]:^20}", end="")
    f.write("\n")
    print("\n")

    f.close()

def main():
    parser = optparse.OptionParser()
    parser.add_option("--options", type="string", dest="options")
    options, args = parser.parse_args()

    json_options = json.loads(open(options.options).read())

    db_mngr = DatabaseManager(json_options["config"]["user"], json_options["config"]["database"], json_options["config"]["password"])

    prizes = fetch_all_data(db_mngr)

    prize_amounts, draws_claimable_prizes, draws_claimable_prizes_amount, draws_dropped_prizes, draws_dropped_prizes_amount, draws_dropped_addresses = accumulate_per_draw(prizes)
    winners_per_draw, unique_winners = unique_winners_per_draw(prizes)

    print_amount_data(draws_claimable_prizes_amount, draws_dropped_prizes_amount, draws_dropped_addresses, winners_per_draw, unique_winners)
    print_per_prize_data(prize_amounts, draws_claimable_prizes, "claimable")
    print_per_prize_data(prize_amounts, draws_dropped_prizes, "dropped")

if __name__ == "__main__":
    main()