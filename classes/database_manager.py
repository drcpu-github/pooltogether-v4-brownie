import psycopg2
import psycopg2.extras
import sys

class DatabaseManager(object):
    def __init__(self, db_user, db_name, db_pass):
        self.db_user = db_user
        self.db_name = db_name
        self.db_pass = db_pass

        # connect to default database
        self.connect("postgres")
        self.create_database()
        self.terminate(verbose=False)
        # connect to expected / created database
        self.connect(self.db_name)

    def connect(self, db_name):
        try:
            if self.db_pass:
                self.connection = psycopg2.connect(user=self.db_user, dbname=db_name, password=self.db_pass)
            else:
                self.connection = psycopg2.connect(user=self.db_user, dbname=db_name)

            # Only set isolation level to autocommit when we still have to create our database
            if db_name == "postgres":
                self.connection.set_isolation_level(psycopg2.extensions.ISOLATION_LEVEL_AUTOCOMMIT)

            self.cursor = self.connection.cursor()
        except Exception as e:
            sys.stderr.write(f"Could not connect to database: {e}\n")

    def create_database(self):
        self.cursor.execute("SELECT 1 FROM pg_catalog.pg_database WHERE datname = '%s'" % (self.db_name,))
        result = self.cursor.fetchone()
        if not result:
            self.cursor.execute("CREATE DATABASE \"%s\" OWNER '%s'" % (self.db_name, self.db_user))

    def register_type(self, type_name):
        psycopg2.extras.register_composite(type_name, self.connection)

    def terminate(self, verbose=True):
        if verbose:
            sys.stdout.write("Terminating database manager\n")
        self.connection.commit()
        self.cursor.close()
        self.connection.close()

    def execute_create_statements(self, sqls):
        for sql in sqls:
            try:
                self.cursor.execute(sql)
            except Exception as e:
                sys.stderr.write(f"Could not execute SQL statement '{sql}', error: {e}\n")
        self.connection.commit()

    def sql_insert_one(self, sql, data):
        try:
            sql = self.cursor.mogrify(sql, data)
            self.cursor.execute(sql)
            self.connection.commit()
        except Exception as e:
            sys.stderr.write(f"Could not execute SQL statement '{sql}', error: {e}\n")

    def sql_return_one(self, sql):
        try:
            self.cursor.execute(sql)
            return self.cursor.fetchone()
        except Exception as e:
            sys.stderr.write(f"Could not execute SQL statement '{sql}', error: {e}\n")
            return None

    def sql_return_all(self, sql):
        try:
            self.cursor.execute(sql)
            return self.cursor.fetchall()
        except Exception as e:
            sys.stderr.write(f"Could not execute SQL statement '{sql}', error: {e}\n")
            return None

    def sql_update_table(self, sql):
        try:
            self.cursor.execute(sql)
            self.connection.commit()
            return self.cursor.rowcount
        except Exception as e:
            sys.stderr.write(f"Could not execute SQL statement '{sql}', error: {e}\n")

    def sql_execute_many(self, sql, data, template=None):
        try:
            if template:
                psycopg2.extras.execute_values(self.cursor, sql, data, template=template, page_size=256)
            else:
                psycopg2.extras.execute_values(self.cursor, sql, data, page_size=256)
            self.connection.commit()
        except Exception as e:
            sys.stderr.write(f"Could not execute SQL statement '{sql}', error: {e}\n")

    def build_sql(self, sql, values):
        try:
            return self.cursor.mogrify(sql, values)
        except Exception as e:
            sys.stderr.write(f"Could not execute SQL statement '{sql}', error: {e}\n")
