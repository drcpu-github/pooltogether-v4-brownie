from classes.database_manager import DatabaseManager

class Helper:
    def insert_draws(self, options, network, draws_dict):
        print("Saving draws to database")

        draws = []
        for draw in draws_dict.values():
            draws.append([
                draw["draw_id"],
                network,
                draw["winning_random_number"],
                draw["timestamp"],
                draw["beacon_period_started_at"],
                draw["beacon_period_seconds"],
            ])
        sql = """
            INSERT INTO draws (
                draw_id,
                network,
                winning_random_number,
                timestamp,
                beacon_period_started_at,
                beacon_period_seconds
            ) VALUES %s
        """

        db_mngr = DatabaseManager(options["user"], options["database"], options["password"])
        db_mngr.sql_execute_many(sql, draws)
        db_mngr.terminate(verbose=False)

    def insert_prize_distributions(self, options, network, prize_distributions_dict):
        print("Saving prize distributions to database")

        prize_distributions = []
        for draw_id, prize_distribution in prize_distributions_dict.items():
            prize_distributions.append([
                draw_id,
                network,
                prize_distribution["bit_range_size"],
                prize_distribution["match_cardinality"],
                prize_distribution["start_timestamp_offset"],
                prize_distribution["end_timestamp_offset"],
                prize_distribution["max_picks_per_user"],
                prize_distribution["expiry_duration"],
                prize_distribution["number_of_picks"],
                [tier for tier in prize_distribution["tiers"]],
                prize_distribution["prize"],
            ])
        sql = """
            INSERT INTO prize_distributions (
                draw_id,
                network,
                bit_range_size,
                match_cardinality,
                start_timestamp_offset,
                end_timestamp_offset,
                max_picks_per_user,
                expiry_duration,
                number_of_picks,
                tiers,
                prize
            ) VALUES %s
        """

        db_mngr = DatabaseManager(options["user"], options["database"], options["password"])
        db_mngr.sql_execute_many(sql, prize_distributions)
        db_mngr.terminate(verbose=False)

    def insert_prizes(self, options, network, prizes_dict):
        print("Saving prizes to database")

        sql_prizes = []
        for user, prizes in prizes_dict.items():
            for prize in sorted(prizes, key=lambda l: l["draw_id"]):
                sql_prizes.append([
                    network,
                    bytearray.fromhex(user[2:]),
                    prize["draw_id"],
                    [int(prize["amount"] * 1E8) for prize in prize["claimable_prizes"]],
                    [prize["pick"] for prize in prize["claimable_prizes"]],
                    [int(prize["amount"] * 1E8) for prize in prize["dropped_prizes"]],
                    [prize["pick"] for prize in prize["dropped_prizes"]],
                    prize["normalized_balance"],
                ])
        sql = """
            INSERT INTO prizes (
                network,
                address,
                draw_id,
                claimable_prizes,
                claimable_picks,
                dropped_prizes,
                dropped_picks,
                normalized_balance
            ) VALUES %s
        """

        db_mngr = DatabaseManager(options["user"], options["database"], options["password"])
        db_mngr.sql_execute_many(sql, sql_prizes)
        db_mngr.terminate(verbose=False)

    def find_draws_to_calculate(self, options, draw_ids, network):
        draw_ids_to_calculate = draw_ids

        # First check the draw ids for which we already calculated prizes
        db_mngr = DatabaseManager(options["user"], options["database"], options["password"])
        sql = """
            SELECT
                draw_id,
                network
            FROM draws
        """
        draws_already_calculated = [draw[0] for draw in db_mngr.sql_return_all(sql) if draw[1] == network]
        draw_ids_to_calculate = list(set(draw_ids_to_calculate) - set(draws_already_calculated))
        db_mngr.terminate(verbose=False)

        return draw_ids_to_calculate