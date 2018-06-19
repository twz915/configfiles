# -*- coding: utf-8 -*-
import logging
import sys
from logging.handlers import TimedRotatingFileHandler
FORMATTER = logging.Formatter("%(asctime)s - %(name)s - %(levelname)s - %(message)s")
LOG_FILE = "my-app.log"


def get_console_handler():
    console_handler = logging.StreamHandler(sys.stdout)
    console_handler.setFormatter(FORMATTER)
    return console_handler


def get_file_handler(file_path=None):
    if not file_path:
       file_path = LOG_FILE
    file_handler = TimedRotatingFileHandler(file_path, when='midnight')
    file_handler.setFormatter(FORMATTER)
    return file_handler


def get_logger(logger_name):
    logger = logging.getLogger(logger_name)
    # better to have too much log than not enough
    logger.setLevel(logging.DEBUG)
    logger.addHandler(get_console_handler())
    logger.addHandler(get_file_handler())
    # it's rarely necessary to propagate the error up to parent
    logger.propagate = False
    return logger


if __name__ == '__main__':
    logger = get_logger('zqxt')
    logger.info('just a test')
    logger.debug('ok')
