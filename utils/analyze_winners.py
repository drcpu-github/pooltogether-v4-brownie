import json
import pickle

from classes.database_manager import DatabaseManager

def fetch_draws(db_mngr):
    sql = """
        SELECT
            draw_id,
            network,
            block_number
        FROM
            draws
        ORDER BY draw_id ASC
    """
    return db_mngr.sql_return_all(sql)

def process_draws(draws):
    draws_dict = {}
    last_draw_id = 0
    for draw_id, network, block_number in draws:
        if network not in draws_dict:
            draws_dict[network] = {}
        draws_dict[network][draw_id] = block_number
        last_draw_id = max(last_draw_id, draw_id)
    return {network: (draws_dict[network][last_draw_id - 1], draws_dict[network][last_draw_id]) for network in draws_dict.keys()}

def process_claim_events(networks, last_draw_blocks):
    claimed_prizes = {}
    for network in networks:
        claimed_prizes[network] = {}
        events = pickle.load(open(f"events/claimeddraw_{network}.bin", "rb"))

        for event in events:
            account = event["args"]["user"][2:].lower()
            prize = event["args"]["payout"]
            block_number = event["blockNumber"]

            if block_number >= last_draw_blocks[network][0] and block_number <= last_draw_blocks[network][1]:
                continue

            if account not in claimed_prizes[network]:
                claimed_prizes[network][account] = 0
            claimed_prizes[network][account] += prize

    return claimed_prizes

def fetch_prizes(db_mngr):
    sql = """
        SELECT
            network,
            address,
            draw_id,
            claimable_prizes,
            average_balance
        FROM
            prizes
        ORDER BY draw_id ASC
    """
    return db_mngr.sql_return_all(sql)

def get_unique_prize_winners(prizes):
    unique_winners = {}
    for prize in prizes:
        _, address, _, claimable_prizes, _ = prize
        address = address.hex()
        if address not in unique_winners:
            unique_winners[address] = 0
        unique_winners[address] += sum(claimable_prizes) if claimable_prizes else 0

    winners = sum(1 for winner, prizes in unique_winners.items() if prizes > 0)

    return len(unique_winners), winners

def get_luckiest_winners(prizes, claimed_amounts):
    winners = {}
    for prize in prizes:
        network, address, draw_id, claimable_prizes, average_balance = prize
        if claimable_prizes:
            assert average_balance > 0
        if average_balance > 0:
            address = address.hex()
            if (address, network) not in winners:
                winners[(address, network)] = [0, 0, 0]
            winners[(address, network)][0] += sum(claimable_prizes) if claimable_prizes else 0
            if average_balance >= winners[(address, network)][1] and draw_id >= winners[(address, network)][2]:
                winners[(address, network)][1] = average_balance
                winners[(address, network)][2] = draw_id

    luckiest_winners = []
    for (address, network), (prize, avg_balance, _) in winners.items():
        prize = prize / 1E14
        avg_balance = avg_balance / 1E6
        if address in claimed_amounts[network]:
            claimed = claimed_amounts[network][address] / 1E6
            rate = claimed / (avg_balance - claimed) * 100
        else:
            rate = 0
        luckiest_winners.append([network, address, round(prize), round(avg_balance), rate])
    luckiest_winners = sorted(luckiest_winners, key=lambda l: l[4], reverse=True)

    return luckiest_winners[:100]

def main():
    options = json.loads(open("options.json").read())
    networks = list(options["contracts"].keys())

    db_mngr = DatabaseManager(options["config"]["user"], options["config"]["database"], options["config"]["password"])

    draws = fetch_draws(db_mngr)
    last_draw_blocks = process_draws(draws)

    claimed_amounts = process_claim_events(networks, last_draw_blocks)

    prizes = fetch_prizes(db_mngr)

    f = open(f"data/players.csv", "w+")

    unique_players, unique_winners = get_unique_prize_winners(prizes)
    f.write(f"Number of unique players,{unique_players}\n")
    print(f" Number of unique players: {unique_players}")
    f.write(f"Number of unique winners,{unique_winners}\n")
    print(f" Number of unique winners: {unique_winners}")
    print("")

    f.close()

    f = open(f"data/luckiest_winners.csv", "w+")

    luckiest_winners = get_luckiest_winners(prizes, claimed_amounts)
    f.write("Rank,Network,Address,Prizes,Balance,Winrate\n")
    print (f"{'Rank':^10}|{'Address':^44}|{'Network':^12}|{'Prizes':^14}|{'Balance':^12}|{'Winrate':^12}")
    print("----------+--------------------------------------------+--------------+------------+------------+------------")
    for i, lw in enumerate(luckiest_winners):
        percentage = f"{lw[4]:.2f}"
        print(f"{i + 1:>9} |{'0x' + lw[1]:>43} |{lw[0]:>11} |{lw[2]:>13} |{lw[3]:>11} |{percentage:>11}%")
        f.write(f"{i + 1},{'0x' + lw[1]},{lw[0]},{lw[2]},{lw[3]},{percentage}%\n")

    f.close()

if __name__ == "__main__":
    main()
