import logging
import time
import sys

def setup_stdout_logger():
    # Configure logger
    logger = logging.getLogger()
    logger.setLevel(logging.INFO)
    logger.handlers = []

    # Add header formatting of the log message
    logging.Formatter.converter = time.gmtime
    formatter = logging.Formatter("[%(levelname)-8s] [%(asctime)s] %(message)s", datefmt="%Y/%m/%d %H:%M:%S")

    # Add console handler
    console_handler = logging.StreamHandler(sys.stdout)
    console_handler.setFormatter(formatter)
    console_handler.setLevel(logging.INFO)
    logger.addHandler(console_handler)
