import json
import optparse
import os
import pickle
import time

from dotenv import load_dotenv
from web3 import Web3
from web3.middleware import geth_poa_middleware

from classes.helper import Helper

# This function is tailored to fetch iterative events from Alchemy and won't work with another node API provider such as Infura
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

# This function is tailored to fetch iterative events from Alchemy and won't work with another node API provider such as Infura
def get_events(event, from_block, to_block):
    print(f"Fetching {event.event_name} events from block {from_block} to block {to_block}")
    event_filter = event.createFilter(fromBlock=from_block, toBlock=to_block)
    try:
        return event_filter.get_all_entries()
    except ValueError as err:
        if "message" in err.args[0] and "Log response size exceeded." in err.args[0]["message"]:
            print(f"Could not fetch all {event.event_name} events at once, falling back to iterative event fetching")
            return get_events_iteratively(event, from_block, to_block)
        else:
            raise

def get_block_boundaries(options, w3_provider):
    last_block = w3_provider.eth.get_block("latest")
    return options["first_block_number"], last_block["number"]

def read_processed_events(events_file, first_block_number):
    events = pickle.load(open(events_file, "rb"))
    if len(events) > 0:
        return events, max([event["blockNumber"] for event in events]) + 1
    else:
        return events, first_block_number + 1

def get_contracts(w3_provider, options):
    abi_yield_source_prize_pool = json.loads(open("abis/YieldSourcePrizePoolAbi.json").read())
    yield_source_prize_pool_contract = w3_provider.eth.contract(address=options["yield_source_prize_pool"], abi=abi_yield_source_prize_pool)

    abi_ticket = json.loads(open("abis/TicketAbi.json").read())
    ticket_contract = w3_provider.eth.contract(address=options["ticket"], abi=abi_ticket)

    abi_prize_distributor = json.loads(open("abis/PrizeDistributorAbi.json").read())
    prize_distributor_contract = w3_provider.eth.contract(address=options["prize_distributor"], abi=abi_prize_distributor)

    abi_draw_calculator_timelock = json.loads(open("abis/DrawCalculatorTimelockAbi.json").read())
    draw_calculator_timelock_contract = w3_provider.eth.contract(address=options["draw_calculator_timelock"], abi=abi_draw_calculator_timelock)

    return yield_source_prize_pool_contract, ticket_contract, prize_distributor_contract, draw_calculator_timelock_contract

def main():
    parser = optparse.OptionParser()
    parser.add_option("--options", type="string", dest="options")
    options, args = parser.parse_args()

    if not os.path.exists("events"):
        os.mkdir("events")

    load_dotenv()

    json_options = json.loads(open(options.options).read())

    helper = Helper()

    networks = list(json_options["contracts"].keys())
    for network in networks:
        print(f"Fetching events for {network}")

        provider = helper.setup_web3_provider(network)

        contract_details = json_options["contracts"][network]

        # Fetch block boundaries
        first_block_number, last_block_number = get_block_boundaries(contract_details, provider)

        # Contracts
        yield_source_prize_pool_contract, ticket_contract, prize_distributor_contract, draw_calculator_timelock_contract = get_contracts(provider, contract_details)

        # Get Deposited events
        deposited_events_file = f"events/deposited_{network}.bin"
        if os.path.exists(deposited_events_file):
            deposited_event_list, deposited_block_number = read_processed_events(deposited_events_file, first_block_number)
            deposited_event_list.extend(get_events(yield_source_prize_pool_contract.events.Deposited, deposited_block_number, last_block_number))
        else:
            deposited_event_list = get_events(yield_source_prize_pool_contract.events.Deposited, first_block_number, last_block_number)
        pickle.dump(deposited_event_list, open(deposited_events_file, "wb"))

        # Get Withdrawal events
        withdrawal_events_file = f"events/withdrawal_{network}.bin"
        if os.path.exists(withdrawal_events_file):
            withdrawal_event_list, withdrawal_block_number = read_processed_events(withdrawal_events_file, first_block_number)
            withdrawal_event_list.extend(get_events(yield_source_prize_pool_contract.events.Withdrawal, withdrawal_block_number, last_block_number))
        else:
            withdrawal_event_list = get_events(yield_source_prize_pool_contract.events.Withdrawal, first_block_number, last_block_number)
        pickle.dump(withdrawal_event_list, open(withdrawal_events_file, "wb"))

        # Get Transfer events
        transfer_events_file = f"events/transfer_{network}.bin"
        if os.path.exists(transfer_events_file):
            transfer_event_list, transfer_block_number = read_processed_events(transfer_events_file, first_block_number)
            transfer_event_list.extend(get_events(ticket_contract.events.Transfer, transfer_block_number, last_block_number))
        else:
            transfer_event_list = get_events(ticket_contract.events.Transfer, first_block_number, last_block_number)
        pickle.dump(transfer_event_list, open(transfer_events_file, "wb"))

        # Get Delegated events
        delegated_events_file = f"events/delegated_{network}.bin"
        if os.path.exists(delegated_events_file):
            delegated_event_list, delegated_block_number = read_processed_events(delegated_events_file, first_block_number)
            delegated_event_list.extend(get_events(ticket_contract.events.Delegated, delegated_block_number, last_block_number))
        else:
            delegated_event_list = get_events(ticket_contract.events.Delegated, first_block_number, last_block_number)
        pickle.dump(delegated_event_list, open(delegated_events_file, "wb"))

        # Get ClaimedDraw events
        claimeddraw_events_file = f"events/claimeddraw_{network}.bin"
        if os.path.exists(claimeddraw_events_file):
            claimeddraw_event_list, claimeddraw_block_number = read_processed_events(claimeddraw_events_file, first_block_number)
            claimeddraw_event_list.extend(get_events(prize_distributor_contract.events.ClaimedDraw, claimeddraw_block_number, last_block_number))
        else:
            claimeddraw_event_list = get_events(prize_distributor_contract.events.ClaimedDraw, first_block_number, last_block_number)
        pickle.dump(claimeddraw_event_list, open(claimeddraw_events_file, "wb"))

        print("")

if __name__ == "__main__":
    main()
