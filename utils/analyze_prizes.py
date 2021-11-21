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
            dropped_picks,
            normalized_balance
        FROM
            prizes
    """
    return db_mngr.sql_return_all(sql)

def get_unique_prize_winners(prizes):
    unique_winners = {}
    for prize in prizes:
        network, address, draw_id, claimable_prizes, claimable_picks, dropped_prizes, dropped_picks, normalized_balance = prize
        address = address.hex()
        if address not in unique_winners:
            unique_winners[address] = 0
        unique_winners[address] += sum(claimable_prizes)

    winners = sum(1 for winner, prizes in unique_winners.items() if prizes > 0)

    return len(unique_winners), winners

def get_luckiest_winners(prizes):
    unique_winners = {}
    for prize in prizes:
        network, address, draw_id, claimable_prizes, claimable_picks, dropped_prizes, dropped_picks, normalized_balance = prize
        address = address.hex()
        if (address, network) not in unique_winners:
            unique_winners[(address, network)] = [network, 0, 0]
        unique_winners[(address, network)][1] += sum(claimable_prizes)
        unique_winners[(address, network)][2] += normalized_balance

    luckiest_winners = sorted([(prizes[0], winner[0], round(prizes[1] / 1E14), prizes[2] / prizes[1]) for winner, prizes in unique_winners.items() if prizes[1] > 0], key=lambda l: l[3])[:10]

    return luckiest_winners

def get_luckiest_winners_per_draw(prizes):
    draw_winners = {}
    for prize in prizes:
        network, address, draw_id, claimable_prizes, claimable_picks, dropped_prizes, dropped_picks, normalized_balance = prize
        address = address.hex()
        if draw_id not in draw_winners:
            draw_winners[draw_id] = {}
        if (address, network) not in draw_winners[draw_id]:
            draw_winners[draw_id][(address, network)] = [network, 0, 0]
        draw_winners[draw_id][(address, network)][1] += sum(claimable_prizes)
        draw_winners[draw_id][(address, network)][2] += normalized_balance

    luckiest_winners = {}
    for draw_id, draw_winners in draw_winners.items():
        luckiest_winners[draw_id] = sorted([(prizes[0], winner[0], round(prizes[1] / 1E14), prizes[2] / prizes[1]) for winner, prizes in draw_winners.items() if prizes[1] > 0], key=lambda l: l[3])[0]

    return luckiest_winners

def main():
    parser = optparse.OptionParser()
    parser.add_option("--options", type="string", dest="options")
    options, args = parser.parse_args()

    json_options = json.loads(open(options.options).read())

    db_mngr = DatabaseManager(json_options["config"]["user"], json_options["config"]["database"], json_options["config"]["password"])

    network_accounts = json.loads(open(json_options["config"]["holders"]).read())
    lower_case_accounts = {}
    for network, accounts in network_accounts.items():
        if network not in lower_case_accounts:
            lower_case_accounts[network] = {}
        for account, balance in accounts.items():
            lower_case_accounts[network][account.lower()] = balance

    prizes = fetch_all_data(db_mngr)

    unique_players, unique_winners = get_unique_prize_winners(prizes)
    print(f" Number of unique players: {unique_players}")
    print(f" Number of unique winners: {unique_winners}")
    print("")

    luckiest_winners = get_luckiest_winners(prizes)
    print (f"{'Network':^10}|{'Address':^44}|{'Prizes':^14}|{'Balance':^12}")
    print("----------+--------------------------------------------+--------------+------------")
    for lw in luckiest_winners:
        balance = lower_case_accounts[lw[0]]["0x" + lw[1]]
        print(f"{lw[0]:^10}|{'0x' + lw[1]:^44}|{lw[2]:>12}  |{round(balance / 1E6):>10}  ")
    print("")

    luckiest_winners_per_draw = get_luckiest_winners_per_draw(prizes)
    print (f"{'Draw':^8}|{'Network':^10}|{'Address':^44}|{'Prizes':^14}|{'Balance':^12}")
    print("--------+----------+--------------------------------------------+--------------+------------")
    for draw_id, luckiest_winner in luckiest_winners_per_draw.items():
        balance = lower_case_accounts[luckiest_winner[0]]["0x" + luckiest_winner[1]]
        print(f"{draw_id:^8}|{luckiest_winner[0]:^10}|{'0x' + luckiest_winner[1]:^44}|{luckiest_winner[2]:>12}  |{round(balance / 1E6):>10}  ")

if __name__ == "__main__":
    main()
