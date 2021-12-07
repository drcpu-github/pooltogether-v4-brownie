# Intro
This repository contains a set of useful scripts to interact with the PoolTogether v4 smart contracts. It contains a Python3 port of the [DrawCalculator NPM package](https://www.npmjs.com/package/@pooltogether/draw-calculator-js) and is meant to be used in combination with Brownie.

DISCLAIMER: Use of this set of scripts is at your own risk. I am in now way liable for any problems that arise due to using these scripts.

# Setup

## Install dependencies to connect to the blockchains

Intall a couple of Python packages:
```
python3 -m pip install --user pipx
python3 -m pipx ensurepath
pipx install eth-brownie
pip3 install eth-abi
pip3 install python-dotenv
pip3 install web3
```

## Setting up brownie

First setup a .env file exporting API keys for Alchemy or Infura. I use Alchemy and run a setup where I have different environment variables for connecting to the Ethereum and Polygon network separately: WEB3_ALCHEMY_ETHEREUM_PROJECT_ID and WEB3_ALCHEMY_POLYGON_PROJECT_ID.

A fresh Brownie installation comes with preconfigured Infura networks. If you want to use Alchemy, you have to add them as below.

```
brownie networks list
brownie networks add Ethereum mainnet-alchemy chainid=1 host='https://eth-mainnet.alchemyapi.io/v2/{WEB3_ALCHEMY_ETHEREUM_PROJECT_ID}' name='Mainnet (Alchemy)'
brownie networks add Polygon polygon-mainnet-alchemy chainid=137 host='https://polygon-mainnet.g.alchemy.com/v2/${WEB3_ALCHEMY_POLYGON_PROJECT_ID}' name='Mainnet (Alchemy)'
```

## Setting up PostgreSQL

Installing the dependencies. Install psycopg2 both locally as well as in the virtualenv from which brownie runs.

```
apt-get install python3-psycopg2 postgresql postgresql-contrib libpq-dev
pip3 install psycopg2
/home/<user>/.local/pipx/venvs/eth-brownie/bin/python3 -m pip install psycopg2
```

Setting up and starting a cluster.

```
pg_createcluster <version (e.g., 10)> <clust name (e.g., main)> --start
service postgresql start
```

Optionally add a new user (if you don't want to use the default postgres user).

```
sudo -i
su postgres
createuser <username>
psql
alter user <username> createdb;
```

Run following script to create the PoolTogether database. Note that it requires an options file.

```
python3 -m utils.create_database <--options options.json>
```

## Install ganache (optional)

Install Ganache if you want to use Brownie in combination with local deployments.

```
npm install -g ganache-cli
```

## Clone PoolTogether contracts (optional)

This is not technically necessary to run the scripts in this repository, but it's nice to have the contracts for future reference and you could deploy them on a local network to test new scripts.

```
mkdir contracts
cd contracts
git clone https://github.com/pooltogether/v4-core.git .
rm -r banner.png deploy hardhat hardhat.config.ts hardhat.network.ts helpers.ts LICENSE package.json README.md scripts templates test tsconfig.json yarn.lock
mv contracts/* .
rm -r contracts
cd ..
```

## Compile source (optional)

This step is only required if you want to deploy the contracts on a local network.

```
brownie compile
```

# Scripts

Below scripts can be used to read and process data from the blockchain. They require a JSON option file containing a couple of configuration variables. The `options.example.json` file contains all necessary configuration. You can remove the `.example` from the filename and edit the variables according to your local setup. You only need to edit the variables under `config`. For `draw_ids`, you can supply any array of draw ids. The `user`, `database` and `password` variables are required to connect to the locally setup database.

## Fetching all depositors

You can calculate all depositors by parsing and processing all events from the blockchain using following script. The `network` argument is required. The `clean` and `validate` arguments are optional. The former is used to force reindexing all events instead of using the locally saved ones. The latter can be used to validate the calculated holders with a holder file downloaded from an explorer. Of course, you could also just use the downloaded tokens holders from etherscan or polygonscan if you wish. Make sure the final depositor file is a JSON file following the format `{"address": balance_1, "address_2": balance_2, ..., "address_n": balance_n}`.

```
python3 -m scripts.get_depositors <--network ethereum | polygon> [--clean] [--validate]
```

## Calculate prizes

The `calculate_prizes.py` script reads some configuration variables from the options JSON file. You can run either the ethereum or polygon version of the script by specifying the function to be executed and the the network to be used by running the following command:

```
brownie run scripts/calculate_prizes.py <calculate_prizes_ethereum | calculate_prizes_polygon> --network <network-name (e.g. mainnet-alchemy | polygon-mainnet-alchemy)>
```

## Claim prizes

Assuming you have pre-calculated prizes for a(n) (set of) account(s) using the `calculate_prizes.py` script, the `claim_prizes.py` script allows to claim prizes for multiple draws in one transaction. Since this script will actually claim prizes, you need to supply an account. Brownie allows for different methods to achieve this, but personally I specify a `PRIVATE_KEY` environment variable in my .env file and load this through the `brownie-config.yaml` file.

```
brownie run scripts/claim_prizes.py --network <network-name, e.g. polygon-mainnet-alchemy>
```

## Other scripts

In the `utils` directory are a set of scripts included which can be used to analyze the draw data. Note that these scripts assume you have the prize data saved in a database. All of these scripts can be executed as:

```
python3 -m utils.<script name> --options options.json
```

## Data

In the data directory, one can find CSV files for an `analyze_draws.py` run and a dump of the prizes database up to draw 52. You should be able to import the latter in your own database ([see the PostgreSQL manual](https://www.postgresql.org/docs/14/backup-dump.html)) if you do not want to calculate the prizes yourself as that can take quite some time. Note that depending on your local setup, you may need to change parts of the `database.sql` file, such as the database owner (which is `pooltogether` by default).
