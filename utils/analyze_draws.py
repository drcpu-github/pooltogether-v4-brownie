import json
import pickle

from classes.database_manager import DatabaseManager

def read_claim_events(networks):
    events = {}
    for network in networks:
        events[network] = pickle.load(open(f"events/claimeddraw_{network}.bin", "rb"))
    return events

def fetch_prizes(db_mngr, draw_id):
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
        WHERE
            draw_id=%s
    """ % draw_id
    return db_mngr.sql_return_all(sql)

def accumulate_prizes(prizes):
    prize_amounts = set()
    claimable_prizes_hist, claimable_prizes_amount = {}, 0
    dropped_prizes_hist, dropped_prizes_amount, dropped_addresses = {}, 0, 0
    for prize in prizes:
        network, address, draw_id, claimable_prizes, claimable_picks, dropped_prizes, dropped_picks = prize

        if claimable_prizes:
            # Sum claimable prizes per prize category
            for claimable_prize in claimable_prizes:
                prize_amounts.add(claimable_prize)
                if claimable_prize not in claimable_prizes_hist:
                    claimable_prizes_hist[claimable_prize] = 0
                claimable_prizes_hist[claimable_prize] += 1
            # Sum all claimable prizes to a single value
            claimable_prizes_amount += sum(claimable_prizes)

        if dropped_prizes:
            # Sum dropped prizes per prize category
            for dropped_prize in dropped_prizes:
                prize_amounts.add(dropped_prize)
                if dropped_prize not in dropped_prizes_hist:
                    dropped_prizes_hist[dropped_prize] = 0
                dropped_prizes_hist[dropped_prize] += 1
            # Sum all dropped prizes to a single value
            dropped_prizes_amount += sum(dropped_prizes)
            if sum(dropped_prizes) > 0:
                dropped_addresses += 1

    return prize_amounts, claimable_prizes_hist, claimable_prizes_amount, dropped_prizes_hist, dropped_prizes_amount, dropped_addresses

def build_prizes_dict(prizes):
    prizes_dict = {}
    for prize in prizes:
        network, address, draw_id, claimable_prizes, claimable_picks, dropped_prizes, dropped_picks = prize
        address = address.hex()
        if network not in prizes_dict:
            prizes_dict[network] = {}
        # Sum prizes per address
        if claimable_prizes:
            prizes_dict[network][address] = round(sum(claimable_prizes) / 1E14)
        else:
            prizes_dict[network][address] = 0
    return prizes_dict

def find_unclaimed_prizes(prizes_dict, claim_events):
    claimed_prizes = {}
    for network, claims in claim_events.items():
        for claim in claims:
            user = claim["args"]["user"]
            draw_id = claim["args"]["drawId"]
            payout = round(claim["args"]["payout"] / 1E6)
            if draw_id not in claimed_prizes:
                claimed_prizes[draw_id] = []
            user = user[2:].lower()
            assert user in prizes_dict[draw_id][network], claim
            assert prizes_dict[draw_id][network][user] - payout >= 0, (network, draw_id, user)
            prizes_dict[draw_id][network][user] -= payout

    draws_unclaimed_prizes, draws_network_unclaimed_prizes = {}, {}
    for draw_id, networks in prizes_dict.items():
        draws_network_unclaimed_prizes[draw_id] = {}
        for network, users in networks.items():
            for user, amount in users.items():
                if draw_id not in draws_unclaimed_prizes:
                    draws_unclaimed_prizes[draw_id] = 0
                if network not in draws_network_unclaimed_prizes[draw_id]:
                    draws_network_unclaimed_prizes[draw_id][network] = 0
                draws_unclaimed_prizes[draw_id] += amount
                draws_network_unclaimed_prizes[draw_id][network] += amount
                assert draws_unclaimed_prizes[draw_id] >= 0, draw
                assert draws_network_unclaimed_prizes[draw_id][network] >= 0, draw

    return draws_unclaimed_prizes, draws_network_unclaimed_prizes

def get_unique_winners(prizes):
    unique_winners = set()
    for prize in prizes:
        network, address, draw_id, claimable_prizes, claimable_picks, dropped_prizes, dropped_picks = prize
        if claimable_prizes and sum(claimable_prizes) > 0:
            unique_winners.add(address.hex())
    return unique_winners

def print_amount_data(draws_claimable_prizes_amount, draws_unclaimed_prizes_amount, draws_dropped_prizes_amount, draws_dropped_addresses, winners_per_draw, unique_winners):
    f = open("data/draw_amounts.csv", "w+")

    draw_ids = list(draws_claimable_prizes_amount.keys())

    # Print amount statistics per draw
    f.write("Draw,Claimable prize amount,Unclaimed prize amount,Dropped prize amount,Total amount,Total unclaimed amount,Winners,Users dropped prizes\n")
    print(f"{'Draw':^8}|{'Claimable prize amount':^25}|{'Unclaimed prize amount':^25}|{'Dropped prize amount':^25}|{'Total amount':^16}|{'Total unclaimed amount':^25}|{'Winners':^12}|{'Users dropped prizes':^25}")
    print("--------+-------------------------+-------------------------+-------------------------+----------------+-------------------------+------------+-------------------------")
    for draw_id in sorted(draw_ids):
        # Round claimable prizes amount to USDC
        draw_claimable_prizes_amount = round(draws_claimable_prizes_amount[draw_id] / 1E14)
        # Unclaimed prizes, already rounded to USDC
        draw_unclaimed_prizes_amount = draws_unclaimed_prizes_amount[draw_id]
        # Round dropped prizes amount to USDC
        draw_dropped_prizes_amount = round(draws_dropped_prizes_amount[draw_id] / 1E14)
        # Sum prizes amount to USDC
        total_prizes_amount = draw_claimable_prizes_amount + draw_dropped_prizes_amount
        # Sum unclaimed prizes amount to USDC
        total_unclaimed_prizes_amount = draw_unclaimed_prizes_amount + draw_dropped_prizes_amount
        # Fetch dropped addresses
        dropped_users = draws_dropped_addresses[draw_id]
        # Fetch unique winners
        winners = winners_per_draw[draw_id]
        f.write(f"{draw_id},{draw_claimable_prizes_amount},{draw_unclaimed_prizes_amount},{draw_dropped_prizes_amount},{total_prizes_amount},{total_unclaimed_prizes_amount},{winners},{dropped_users}\n")
        print(f"{draw_id:^8}|{draw_claimable_prizes_amount:^25}|{draw_unclaimed_prizes_amount:^25}|{draw_dropped_prizes_amount:^25}|{total_prizes_amount:^16}|{total_unclaimed_prizes_amount:^25}|{winners:^12}|{dropped_users:^25}")
    print("--------+-------------------------+-------------------------+-------------------------+----------------+-------------------------+------------+-------------------------")

    # Round claimable prizes amount to USDC
    total_claimable_prizes_amount = round(sum(draws_claimable_prizes_amount.values()) / 1E14)
    # Unclaimed prizes, already rounded to USDC
    total_unclaimed_prizes_amount = sum(draws_unclaimed_prizes_amount.values())
    # Round dropped prizes amount to USDC
    total_dropped_prizes_amount = round(sum(draws_dropped_prizes_amount.values()) / 1E14)
    # Sum prizes amount to USDC
    total_prizes_amount = total_claimable_prizes_amount + total_dropped_prizes_amount
    # Sum prizes unclaimed amount to USDC
    total_prizes_unclaimed_amount = total_unclaimed_prizes_amount + total_dropped_prizes_amount
    # Sum dropped addresses
    total_dropped_users = sum(draws_dropped_addresses.values())
    f.write(f"total,{total_claimable_prizes_amount},{total_unclaimed_prizes_amount},{total_dropped_prizes_amount},{total_prizes_amount},{total_prizes_unclaimed_amount},{unique_winners},{total_dropped_users}\n")
    print(f"{'Total':^8}|{total_claimable_prizes_amount:^25}|{total_unclaimed_prizes_amount:^25}|{total_dropped_prizes_amount:^25}|{total_prizes_amount:^16}|{total_prizes_unclaimed_amount:^25}|{unique_winners:^12}|{total_dropped_users:^25}")

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

def print_unclaimed_prizes_per_network(draws_network_unclaimed_prizes):
    f = open(f"data/unclaimed_prizes.csv", "w+")

    print(f"{'Network':^12}|{'Unclaimed amount':^20}")
    f.write("Network,Unclaimed amount\n")
    print("------------+--------------------")

    total_unclaimed_amount = {}
    for draw, networks in sorted(draws_network_unclaimed_prizes.items())[-60:]:
        for network, amount in networks.items():
            if network not in total_unclaimed_amount:
                total_unclaimed_amount[network] = 0
            total_unclaimed_amount[network] += amount

    for network, amount in sorted(total_unclaimed_amount.items()):
        print(f"{network:^12}|{amount:^20}")
        f.write(f"{network},{amount}\n")

    print("------------+--------------------")
    print(f"{'total':^12}|{sum(total_unclaimed_amount.values()):^20}")
    f.write(f"{'total'},{sum(total_unclaimed_amount.values())}\n")

    f.close()

def main():
    options = json.loads(open("options.json").read())

    db_mngr = DatabaseManager(options["config"]["user"], options["config"]["database"], options["config"]["password"])

    networks = list(options["contracts"].keys())
    claim_events = read_claim_events(networks)

    draw_id = 1

    prize_values = set()
    claimable_prizes, claimable_prizes_amount, dropped_prizes, dropped_prizes_amount, dropped_addresses = {}, {}, {}, {}, {}

    prizes_dict = {}

    unique_winners = set()
    winners_per_draw = {}

    while True:
        print(draw_id)
        prizes = fetch_prizes(db_mngr, draw_id)
        if len(prizes) == 0:
            break

        prize_amounts, claimable_prizes[draw_id], claimable_prizes_amount[draw_id], dropped_prizes[draw_id], dropped_prizes_amount[draw_id], dropped_addresses[draw_id] = accumulate_prizes(prizes)
        prize_values.update(prize_amounts)

        prizes_dict[draw_id] = build_prizes_dict(prizes)

        winners = get_unique_winners(prizes)
        unique_winners.update(winners)
        winners_per_draw[draw_id] = len(winners)

        draw_id += 1

    draws_unclaimed_prizes_amount, draws_network_unclaimed_prizes = find_unclaimed_prizes(prizes_dict, claim_events)

    print_amount_data(claimable_prizes_amount, draws_unclaimed_prizes_amount, dropped_prizes_amount, dropped_addresses, winners_per_draw, len(unique_winners))
    print_per_prize_data(prize_values, claimable_prizes, "claimable")
    print_per_prize_data(prize_values, dropped_prizes, "dropped")

    print_unclaimed_prizes_per_network(draws_network_unclaimed_prizes)

if __name__ == "__main__":
    main()
