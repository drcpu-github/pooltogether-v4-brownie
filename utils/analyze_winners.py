import json

from classes.database_manager import DatabaseManager

def fetch_all_data(db_mngr):
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

def get_luckiest_winners(prizes):
    winners = {}
    for prize in prizes:
        network, address, _, claimable_prizes, average_balance = prize
        address = address.hex()
        if (address, network) not in winners:
            winners[(address, network)] = [0, []]
        winners[(address, network)][0] += sum(claimable_prizes) if claimable_prizes else 0
        winners[(address, network)][1].append(average_balance)

    luckiest_winners = []
    for (address, network), (prize, balances) in winners.items():
        if sum(balances) > 0:
            prize = prize / 1E14
            avg_balance = sum(balances) / sum(balance > 0 for balance in balances) / 1E6
            ratio = max(0, prize - avg_balance) / avg_balance
            if prize > 0 and ratio > 0:
                luckiest_winners.append([network, address, round(prize), round(avg_balance), ratio])
    luckiest_winners = sorted(luckiest_winners, key=lambda l: l[4], reverse=True)[:25]

    return luckiest_winners

def get_luckiest_winners_per_draw(prizes):
    draw_winners = {}
    for prize in prizes:
        network, address, draw_id, claimable_prizes, average_balance = prize
        address = address.hex()
        if draw_id not in draw_winners:
            draw_winners[draw_id] = {}
        if (address, network) not in draw_winners[draw_id]:
            draw_winners[draw_id][(address, network)] = [0, 0]
        draw_winners[draw_id][(address, network)][0] += sum(claimable_prizes) if claimable_prizes else 0
        draw_winners[draw_id][(address, network)][1] += average_balance

    luckiest_draw_winner = {}
    for draw_id, draw_winners in draw_winners.items():
        for (address, network), (prize, balance) in draw_winners.items():
            if balance > 0:
                prize = prize / 1E14
                balance = balance / 1E6
                ratio = max(0, prize - balance) / balance
                if prize > 0 and (draw_id not in luckiest_draw_winner or ratio > luckiest_draw_winner[draw_id][-1]):
                    luckiest_draw_winner[draw_id] = [network, address, round(prize), round(balance), ratio]

    return luckiest_draw_winner

def main():
    options = json.loads(open("options.json").read())

    db_mngr = DatabaseManager(options["config"]["user"], options["config"]["database"], options["config"]["password"])

    prizes = fetch_all_data(db_mngr)

    unique_players, unique_winners = get_unique_prize_winners(prizes)
    print(f" Number of unique players: {unique_players}")
    print(f" Number of unique winners: {unique_winners}")
    print("")

    luckiest_winners = get_luckiest_winners(prizes)
    print (f"{'Network':^10}|{'Address':^44}|{'Prizes':^14}|{'Balance':^12}")
    print("----------+--------------------------------------------+--------------+------------")
    for lw in luckiest_winners:
        print(f"{lw[0]:^10}|{'0x' + lw[1]:^44}|{lw[2]:>12}  |{lw[3]:>10}  ")
    print("")

    luckiest_winners_per_draw = get_luckiest_winners_per_draw(prizes)
    print (f"{'Draw':^8}|{'Network':^10}|{'Address':^44}|{'Prizes':^14}|{'Balance':^12}")
    print("--------+----------+--------------------------------------------+--------------+------------")
    for draw_id, lw in sorted(luckiest_winners_per_draw.items()):
        print(f"{draw_id:^8}|{lw[0]:^10}|{'0x' + lw[1]:^44}|{lw[2]:>12}  |{lw[3]:>10}  ")

if __name__ == "__main__":
    main()
