import datetime
import os
import subprocess

def execute_command(command, output_file):
    if output_file:
        f = open(output_file, "w+")
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

    print("Calculating depositors")
    execute_command(["python3", "-m", "utils.depositors", "--draws"], f"logs/depositors_{timestamp}.log")

    for network, rpc in networks.items():
        print(f"Calculating prizes for {network}")
        execute_command(["/home/pooltogether/.local/bin/brownie", "run", "scripts/calculate_prizes.py", f"calculate_prizes_{network.lower()}", "--network", rpc], f"logs/calculate_prizes_{network.lower()}_{timestamp}.log")

    print("Dump database")
    execute_command(["pg_dump", "pooltogether"], f"data/database.sql")

    print("Analyzing draws")
    return_code = execute_command(["python3", "-m", "utils.analyze_draws"], f"logs/analyze_draws_{timestamp}.log")

    if return_code == 0:
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

            # Commit
            print("Committing data")
            if ", " in draws:
                commit_message = f"[data] Updated data files for draws {draws}"
            else:
                commit_message = f"[data] Updated data files for draw {draws}"
            execute_command(["git", "commit", f"data/*", "-m", f"{commit_message}"], None)

            # Push
            execute_command(["git", "push"], None)
        else:
            print("Nothing to commit")

if __name__ == "__main__":
    main()
