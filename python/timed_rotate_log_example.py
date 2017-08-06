#!/usr/bin/python
import logging
from logging.handlers import TimedRotatingFileHandler

logging.basicConfig(format='%(asctime)s %(levelname)s: %(message)s')

logger = logging.getLogger(__name__)
formatter = logging.Formatter('%(asctime)s %(name)s %(levelname)s %(message)s')
handler = TimedRotatingFileHandler(filename='/Users/tu/testlog.log', when='D')
handler.setFormatter(formatter)
logger.addHandler(handler)
logger.setLevel(logging.DEBUG)

logger.debug('log content')
