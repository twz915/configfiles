# -*- coding: utf-8 -*-
import logging
from logging.config import dictConfig


logging_config = {
    'version': 1,
    'disable_existing_loggers': False,
    'formatters': {
        'standard': {
            'format': '%(asctime)s [%(levelname)s] %(name)s: %(message)s'
        },
    },
    'handlers': {
        'default': {
            'level': 'DEBUG',
            'formatter': 'standard',
            'class': 'logging.StreamHandler',
        },
        'file': {
            'level': 'DEBUG',
            'formatter': 'standard',
            'class': 'logging.handlers.TimedRotatingFileHandler',
            'filename': './test_dict_config.log',
        },
    },
    'loggers': {
        '': {
            'handlers': ['default', 'file'],
            'level': 'DEBUG',
            'propagate': True
        },
        'django.db': {
            'handlers': ['default'],
            'level': 'DEBUG',
            'propagate': False
        },
    }
}

dictConfig(logging_config)


if __name__ == '__main__':
    # log content -> logger -> handler
    logger = logging.getLogger('app-name')
    logger.debug('logging dict works very well')
