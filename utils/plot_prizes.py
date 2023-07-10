import json
import os
import sys

import matplotlib.pyplot as plt

def group_per_draw(prizes):
    per_draw = {}

    for account, prizes in prizes.items():
        for prize in prizes:
            if not prize["draw_id"] in per_draw:
                per_draw[prize["draw_id"]] = []
            per_draw[prize["draw_id"]].append([len(prize["claimable_prizes"]), prize["total_value_claimable"], len(prize["dropped_prizes"]), prize["total_value_dropped"], prize["normalized_balance"]])

    sorted_per_draw = {}
    for draw_id, prizes in per_draw.items():
        sorted_per_draw[draw_id] = sorted(prizes, key=lambda l: l[-1], reverse=True)

    return sorted_per_draw

def group_per_account(prizes):
    per_account = {"claimable_prizes": [], "total_value_claimable": [], "dropped_prizes": [], "total_value_dropped": []}

    for account, prizes in prizes.items():
        per_account["claimable_prizes"].append([sum(len(prize["claimable_prizes"]) for prize in prizes), sum(prize["normalized_balance"] for prize in prizes)])
        per_account["total_value_claimable"].append([sum(prize["total_value_claimable"] for prize in prizes), sum(prize["normalized_balance"] for prize in prizes)])
        per_account["dropped_prizes"].append([sum(len(prize["dropped_prizes"]) for prize in prizes), sum(prize["normalized_balance"] for prize in prizes)])
        per_account["total_value_dropped"].append([sum(prize["total_value_dropped"] for prize in prizes), sum(prize["normalized_balance"] for prize in prizes)])

    per_account["claimable_prizes"] = sorted(per_account["claimable_prizes"], key=lambda l: l[1], reverse=True)
    per_account["total_value_claimable"] = sorted(per_account["total_value_claimable"], key=lambda l: l[1], reverse=True)
    per_account["dropped_prizes"] = sorted(per_account["dropped_prizes"], key=lambda l: l[1], reverse=True)
    per_account["total_value_dropped"] = sorted(per_account["total_value_dropped"], key=lambda l: l[1], reverse=True)

    return per_account

def plot_prizes(per_account, plot_range=(0, sys.maxsize)):
    x_range = range(0, len(per_account["claimable_prizes"]))[plot_range[0]:plot_range[1]]
    claimable_prizes = [prize[0] for prize in per_account["claimable_prizes"]][plot_range[0]:plot_range[1]]
    dropped_prizes = [prize[0] for prize in per_account["dropped_prizes"]][plot_range[0]:plot_range[1]]

    fig, ax = plt.subplots()
    plt.stackplot(x_range, claimable_prizes, dropped_prizes, labels=["Claimable prizes", "Dropped prizes"])

    plt.legend()

    if plot_range == (0, sys.maxsize):
        label = "all"
    else:
        label = f"{plot_range[0]}-{plot_range[1]}"

    plt.savefig(f"plots/prizes_{label}.png", bbox_inches="tight")

    print(f"Total prizes claimed (by {label} addresses): {sum(claimable_prizes)}")
    print(f"Total prizes dropped (by {label} addresses): {sum(dropped_prizes)}")

def plot_prize_values(per_account, plot_range=(0, sys.maxsize)):
    x_range = range(0, len(per_account["claimable_prizes"]))[plot_range[0]:plot_range[1]]
    total_value_claimable = [prize[0] for prize in per_account["total_value_claimable"]][plot_range[0]:plot_range[1]]
    total_value_dropped = [prize[0] for prize in per_account["total_value_dropped"]][plot_range[0]:plot_range[1]]

    fig, ax = plt.subplots()
    plt.stackplot(x_range, total_value_claimable, total_value_dropped, labels=["Claimable value", "Dropped value"])

    plt.legend()

    if plot_range == (0, sys.maxsize):
        label = "all"
    else:
        label = f"{plot_range[0]}-{plot_range[1]}"

    plt.savefig(f"plots/values_{label}.png", bbox_inches="tight")

    print(f"Total value claimed (by {label} addresses): {sum(total_value_claimable)}")
    print(f"Total value dropped (by {label} addresses): {sum(total_value_dropped)}")

def main():
    parser = optparse.OptionParser()
    parser.add_option("--json", type="string", dest="json")
    options, args = parser.parse_args()

    prizes = json.loads(open(options.json).read())

    if not os.path.exists("plots"):
        os.mkdir("plots")

    per_draw = group_per_draw(prizes)

    per_account = group_per_account(prizes)
    plot_prizes(per_account)
    # plot_prizes(per_account, plot_range=(0, 200))
    # plot_prizes(per_account, plot_range=(1000, 1100))
    plot_prize_values(per_account)
    # plot_prize_values(per_account, plot_range=(0, 100))
    # plot_prize_values(per_account, plot_range=(1000, 1100))

if __name__ == "__main__":
    main()