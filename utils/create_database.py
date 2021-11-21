import json
import optparse

from classes.database_manager import DatabaseManager

def create_tables(db_mngr):
        types = [
                """DO $$
                    BEGIN
                        IF NOT EXISTS (SELECT 1 FROM pg_type WHERE typname = 'prize') THEN
                            CREATE TYPE prize AS (
                                amount BIGINT,
                                distribution_index SMALLINT,
                                pick INT
                            );
                        END IF;
                    END
                $$;
                COMMIT;""",
        ]

        tables = [
            """CREATE TABLE IF NOT EXISTS draws (
                draw_id INT NOT NULL,
                network VARCHAR(16) NOT NULL,
                winning_random_number NUMERIC(78, 0) NOT NULL,
                timestamp BIGINT NOT NULL,
                beacon_period_started_at BIGINT NOT NULL,
                beacon_period_seconds INT NOT NULL,
                CONSTRAINT pk_draws PRIMARY KEY (draw_id, network)
            );""",

            """CREATE TABLE IF NOT EXISTS prize_distributions (
                draw_id INT NOT NULL,
                network VARCHAR(16) NOT NULL,
                bit_range_size SMALLINT NOT NULL,
                match_cardinality SMALLINT NOT NULL,
                start_timestamp_offset BIGINT NOT NULL,
                end_timestamp_offset BIGINT NOT NULL,
                max_picks_per_user INT NOT NULL,
                expiry_duration INT NOT NULL,
                number_of_picks BIGINT NOT NULL,
                tiers BIGINT ARRAY NOT NULL,
                prize BIGINT NOT NULL,
                CONSTRAINT pk_prize_distributions PRIMARY KEY (draw_id, network)
            );""",

            """CREATE TABLE IF NOT EXISTS prizes (
                network VARCHAR(16) NOT NULL,
                address BYTEA NOT NULL,
                draw_id INT NOT NULL,
                claimable_prizes BIGINT ARRAY NOT NULL,
                claimable_picks INT ARRAY NOT NULL,
                dropped_prizes BIGINT ARRAY NOT NULL,
                dropped_picks INT ARRAY NOT NULL,
                normalized_balance BIGINT NOT NULL,
                CONSTRAINT pk_prizes PRIMARY KEY (network, address, draw_id)
            );""",
        ]

        db_mngr.execute_create_statements(types)
        db_mngr.register_type("prize")

        db_mngr.execute_create_statements(tables)

def main():
    parser = optparse.OptionParser()
    parser.add_option("--options", type="string", dest="options")
    options, args = parser.parse_args()

    json_options = json.loads(open(options.options).read())

    db_mngr = DatabaseManager(json_options["config"]["user"], json_options["config"]["database"], json_options["config"]["password"])

    create_tables(db_mngr)

if __name__ == "__main__":
    main()
