import json
import optparse
import os
import pickle
import time

from dotenv import load_dotenv
from web3 import Web3
from web3.middleware import geth_poa_middleware

# This function is tailor made for fetching iterative events from Alchemy and won't work with another node API provider such as Infura
def get_events_iteratively(event, from_block, to_block, blocks_per_call=100000):
    print(f"Fetching {event.event_name} events iteratively from {from_block} to {to_block} limited to {blocks_per_call} blocks")
    events = []
    for block in range(from_block, to_block, blocks_per_call):
        fetch_until = min(to_block, block + blocks_per_call)
        print(f"Fetching {event.event_name} events for block {block} to {fetch_until} (fetching until block {to_block})")
        event_filter = event.createFilter(fromBlock=block, toBlock=fetch_until)
        try:
            events.extend(event_filter.get_all_entries())
        except ValueError as err:
            if "message" in err.args[0] and "Log response size exceeded." in err.args[0]["message"]:
                print(f"Could not fetch all events at once, falling back to iterative event fetching")
                events.extend(get_events_iteratively(event, block, to_block, blocks_per_call=int(blocks_per_call / 2)))
                break
            else:
                raise
        time.sleep(0.2)
    return events

# This function is tailor made for fetching iterative events from Alchemy and won't work with another node API provider such as Infura
def get_events(event, from_block, to_block):
    print(f"Fetching {event.event_name} events")
    event_filter = event.createFilter(fromBlock=from_block, toBlock=to_block)
    try:
        return event_filter.get_all_entries()
    except ValueError as err:
        if "message" in err.args[0] and "Log response size exceeded." in err.args[0]["message"]:
            print(f"Could not fetch all {event.event_name} events at once, falling back to iterative event fetching")
            return get_events_iteratively(event, from_block, to_block)
        else:
            raise

def main():
    parser = optparse.OptionParser()
    parser.add_option("--network", type="string", dest="network")
    parser.add_option("--clean", action="store_true", dest="clean")
    parser.add_option("--validate", action="store_true", dest="validate")
    options, args = parser.parse_args()

    load_dotenv()

    json_options = json.loads(open("options.json").read())

    # Setup web3 provider
    if options.network == "ethereum":
        WEB3_ALCHEMY_ETHEREUM_PROJECT_ID = os.getenv("WEB3_ALCHEMY_ETHEREUM_PROJECT_ID")
        w3 = Web3(Web3.HTTPProvider(f"https://eth-mainnet.alchemyapi.io/v2/{WEB3_ALCHEMY_ETHEREUM_PROJECT_ID}"))
    elif options.network == "polygon":
        WEB3_ALCHEMY_POLYGON_PROJECT_ID = os.getenv("WEB3_ALCHEMY_POLYGON_PROJECT_ID")
        w3 = Web3(Web3.HTTPProvider(f"https://polygon-mainnet.g.alchemy.com/v2/{WEB3_ALCHEMY_POLYGON_PROJECT_ID}"))
        w3.middleware_onion.inject(geth_poa_middleware, layer=0)
    else:
        raise ValueError("Only ethereum and polygon networks are valid options")

    # Calculate oldest block
    first_block_number = min(
        json_options["contracts"][options.network]["prize_distributor_deployed_block_number"],
        json_options["contracts"][options.network]["yield_source_prize_pool_deployed_block_number"],
        json_options["contracts"][options.network]["ticket_deployed_block_number"]
    )

    # Fetch current block
    last_block = w3.eth.get_block("latest")
    last_block_number = last_block["number"]

    # Get Deposit and Withdraw events
    abi_yield_source_prize_pool = json.loads(open("abis/YieldSourcePrizePoolAbi.json").read())
    yield_source_prize_pool_contract = w3.eth.contract(address=json_options["contracts"][options.network]["yield_source_prize_pool_address"], abi=abi_yield_source_prize_pool)

    if not os.path.exists("events"):
        os.mkdir("events")

    if options.clean or not os.path.exists(f"events/deposited_{options.network}.bin"):
        deposit_event_list = get_events(yield_source_prize_pool_contract.events.Deposited, first_block_number, last_block_number)
        pickle.dump(deposit_event_list, open(f"events/deposited_{options.network}.bin", "wb"))
    else:
        print("Loading Deposited events")
        deposit_event_list = pickle.load(open(f"events/deposited_{options.network}.bin", "rb"))

    if options.clean or not os.path.exists(f"events/withdrawal_{options.network}.bin"):
        withdraw_event_list = get_events(yield_source_prize_pool_contract.events.Withdrawal, first_block_number, last_block_number)
        pickle.dump(withdraw_event_list, open(f"events/withdrawal_{options.network}.bin", "wb"))
    else:
        print("Loading Withdrawal events")
        withdraw_event_list = pickle.load(open(f"events/withdrawal_{options.network}.bin", "rb"))

    # Get Transfer and Delegate events
    abi_ticket = json.loads(open("abis/TicketAbi.json").read())
    ticket_contract = w3.eth.contract(address=json_options["contracts"][options.network]["ticket_address"], abi=abi_ticket)

    if options.clean or not os.path.exists(f"events/transfer_{options.network}.bin"):
        transfer_event_list = get_events(ticket_contract.events.Transfer, first_block_number, last_block_number)
        pickle.dump(transfer_event_list, open(f"events/transfer_{options.network}.bin", "wb"))
    else:
        print("Loading Transfer events")
        transfer_event_list = pickle.load(open(f"events/transfer_{options.network}.bin", "rb"))

    if options.clean or not os.path.exists(f"events/delegated_{options.network}.bin"):
        delegate_event_list = get_events(ticket_contract.events.Delegated, first_block_number, last_block_number)
        pickle.dump(delegate_event_list, open(f"events/delegated_{options.network}.bin", "wb"))
    else:
        print("Loading Delegated events")
        delegate_event_list = pickle.load(open(f"events/delegated_{options.network}.bin", "rb"))

    # Get Claim events
    abi_prize_distributor = json.loads(open("abis/PrizeDistributorAbi.json").read())
    prize_distributor_contract = w3.eth.contract(address=json_options["contracts"][options.network]["prize_distributor_address"], abi=abi_prize_distributor)

    if options.clean or not os.path.exists(f"events/claimeddraw_{options.network}.bin"):
        claim_event_list = get_events(prize_distributor_contract.events.ClaimedDraw, first_block_number, last_block_number)
        pickle.dump(claim_event_list, open(f"events/claimeddraw_{options.network}.bin", "wb"))
    else:
        print("Loading ClaimedDraw events")
        claim_event_list = pickle.load(open(f"events/claimeddraw_{options.network}.bin", "rb"))

    holders = {}
    for deposit in deposit_event_list:
        holder = deposit["args"]["to"]
        amount = deposit["args"]["amount"]

        # Ignore deposit to the PrizeDistributor contract
        if holder == json_options["contracts"][options.network]["prize_distributor_address"]:
            continue

        if holder not in holders:
            holders[holder] = 0
        holders[holder] += amount

    for transfer in transfer_event_list:
        # Mint operation due to a deposit, ignore these
        if "from" in transfer["args"] and transfer["args"]["from"] == "0x0000000000000000000000000000000000000000":
            continue

        # Burn operation due to a whitdrawal, ignore these
        if "to" in transfer["args"] and transfer["args"]["to"] == "0x0000000000000000000000000000000000000000":
            continue

        # Claims, process these as separate events
        if "from" in transfer["args"] and transfer["args"]["from"] == json_options["contracts"][options.network]["prize_distributor_address"]:
            continue

        # Ignore transfers from the Reserve contract
        if "from" in transfer["args"] and transfer["args"]["from"] == json_options["contracts"][options.network]["reserve_address"]:
            continue

        # Actual ticket transfers
        sender = transfer["args"]["from"]
        recipient = transfer["args"]["to"]
        value = transfer["args"]["value"]
        assert sender in holders, transfer
        if recipient not in holders:
            holders[recipient] = 0
        holders[recipient] += value
        holders[sender] -= value

    # Insert delegated addresses into the holders list, but don't increase their balance
    for delegate in delegate_event_list:
        delegator = delegate["args"]["delegator"]
        delegatee = delegate["args"]["delegate"]
        if delegator != delegatee:
            holders[delegatee] = holders.get(delegatee, 0)

    # Process claims
    claim_histogram = {}
    for claim in claim_event_list:
        claimee = claim["args"]["user"]
        payout = claim["args"]["payout"]
        if not payout in claim_histogram:
            claim_histogram[payout] = 0
        claim_histogram[payout] += 1
        assert claimee in holders, (claimee, payout)
        holders[claimee] += payout
    print(claim_histogram)

    # Process withdraws
    for withdraw in withdraw_event_list:
        holder = withdraw["args"]["from"]
        amount = withdraw["args"]["amount"]
        holders[holder] -= amount
        assert holders[holder] >= 0, (holder, amount, holders[holder])

    if options.validate:
        print(f"Validating holders and their total balance with results downloaded from {'Etherscan' if options.network == 'Ethereum' else 'Polygonscan'}. Make sure these are up to date!")

        print(f"Total holders: {sum([1 for holder, amount in holders.items() if amount > 0])}")

        if options.network == "ethereum":
            f = open("holders_etherscan.csv", "r")
        elif options.network == "polygon":
            f = open("holders_polygonscan.csv", "r")
        else:
            raise ValueError("Only ethereum and polygon networks are valid options")

        explorer_holders = {}
        for line in f:
            holder, amount = line.split(",")
            explorer_holders[holder] = int(float(amount) * 1E6)

        for holder, amount in holders.items():
            if amount == 0:
                continue
            holder = holder.lower()
            # Tackle rounding errors
            if holder in explorer_holders and abs(explorer_holders[holder] - amount) > 1:
                print(holder, amount, explorer_holders[holder])

    print("Dumping all holders to holders.json")
    if os.path.exists(json_options["config"]["holders"]):
        updated_holders = json.loads(open(json_options["config"]["holders"]).read())
    else:
        updated_holders = {}
    updated_holders[options.network] = holders
    json.dump(updated_holders, open(json_options["config"]["holders"], "w+"))

if __name__ == "__main__":
    main()
