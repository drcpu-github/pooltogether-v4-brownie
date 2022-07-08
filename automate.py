import datetime
import os
import subprocess

def execute_command(command, output_file):
    if output_file:
        f = open(output_file, "a+")
        p = subprocess.Popen(command, stdout=f, stderr=f)
        p.communicate()
        f.close()
    else:
        p = subprocess.Popen(command)
        p.communicate()

    return p.returncode

def main():
    networks = {
        "Ethereum": "mainnet-alchemy",
        "Polygon": "polygon-mainnet-alchemy",
        "Avalanche": "avalanche-mainnet",
        "Optimism": "optimism-mainnet",
    }

    if os.path.exists(".draws_calculated"):
        os.remove(".draws_calculated")

    if not os.path.exists("logs"):
        os.mkdir("logs")

    timestamp = datetime.datetime.now().strftime("%F")

    print("Fetching events")
    execute_command(["python3", "-m", "utils.get_events"], f"logs/events_{timestamp}.log")

    for network, rpc in networks.items():
        print(f"Fetching draws for {network}")
        execute_command(["/home/pooltogether/.local/bin/brownie", "run", "scripts/get_draws.py", f"get_draws_{network.lower()}", "--network", rpc], f"logs/get_draws_{network.lower()}_{timestamp}.log")

    if os.path.exists(".draws_fetched"):
        f = open(".draws_fetched", "r")
        networks_fetched = set([line.split(":")[0] for line in f.readlines()])
        f.close()

        all_networks = set([network.lower() for network in networks.keys()])

        if all_networks - networks_fetched != set():
            return
    else:
        return

    os.remove(".draws_fetched")

    print("Calculating depositors")
    execute_command(["python3", "-m", "utils.depositors", "--draws"], f"logs/depositors_{timestamp}.log")

    for network, rpc in networks.items():
        print(f"Calculating prizes for {network}")
        execute_command(["/home/pooltogether/.local/bin/brownie", "run", "scripts/calculate_prizes.py", f"calculate_prizes_{network.lower()}", "--network", rpc], f"logs/calculate_prizes_{network.lower()}_{timestamp}.log")

    print("Dump database")
    os.system("rm data/data.sql.*")
    execute_command(["pg_dump", "--schema-only", "pooltogether"], "data/schema.sql")
    execute_command(["pg_dump", "--data-only", "pooltogether"], "data/data.sql")
    execute_command(["split", "-b", "32m", "-d", "data/data.sql", "data/data.sql."], None)
    os.system("rm data/data.sql")

    print("Analyzing draws")
    return_code_1 = execute_command(["python3", "-m", "utils.analyze_draws"], f"logs/analyze_draws_{timestamp}.log")

    print("Analyzing winners")
    return_code_2 = execute_command(["python3", "-m", "utils.analyze_winners"], f"logs/analyze_winners_{timestamp}.log")

    if return_code_1 + return_code_2 == 0:
        if os.path.exists(".draws_calculated"):
            # Read draws calculated
            f = open(".draws_calculated", "r")
            lines = f.readlines()
            f.close()

            # Create superset of all draws calculated
            draws = []
            for line in lines:
                draws.extend([int(draw) for draw in line.split(":")[-1].split(", ")])
            draws = ", ".join([str(draw_id) for draw_id in list(set(draws))])

            # Add potentially new files
            execute_command(["git", "add", "data/*"], f"logs/git_{timestamp}.log")

            # Commit
            print("Committing data")
            if ", " in draws:
                commit_message = f"[data] Updated data files for draws {draws}"
            else:
                commit_message = f"[data] Updated data files for draw {draws}"
            execute_command(["git", "commit", "data/*", "-m", f"{commit_message}"], f"logs/git_{timestamp}.log")

            # Push
            execute_command(["git", "push"], f"logs/git_{timestamp}.log")
        else:
            print("Nothing to commit")

if __name__ == "__main__":
    main()
