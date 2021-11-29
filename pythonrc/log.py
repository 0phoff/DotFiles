################################
# LOGGING : Colored log output #
################################
import os
import copy
import logging
from enum import Enum

__all__ = ['log']


class ColorCode(Enum):
    """ Color Codes """
    RESET = '\033[00m'
    BOLD = '\033[01m'

    RED = '\033[31m'
    GREEN = '\033[32m'
    YELLOW = '\033[33m'
    BLUE = '\033[34m'
    WHITE = '\033[37m'
    GRAY = '\033[1;30m'


class ColoredFormatter(logging.Formatter):
    def __init__(self, msg, color=True, **kwargs):
        logging.Formatter.__init__(self, msg, **kwargs)
        self.color = color
        self.color_codes = {
            'ERROR': ColorCode.RED,
            'WARNING': ColorCode.YELLOW,
            'INFO': ColorCode.WHITE,
            'DEBUG': ColorCode.GRAY,
        }

    def format(self, record):
        record = copy.copy(record)
        levelname = record.levelname
        if self.color:
            color = self.color_codes[levelname] if levelname in self.color_codes else ''
            record.levelname = f'{ColorCode.BOLD.value}{color.value}{levelname:8}{ColorCode.RESET.value}'
        else:
            record.levelname = f'{levelname:8}'
        return logging.Formatter.format(self, record)

    def setColor(self, value):
        """ Enable or disable colored output for this handler """
        self.color = value


ch = logging.StreamHandler()
ch.setFormatter(ColoredFormatter('{levelname} {message}', style='{'))
if 'STARTUP_LOGLVL' in os.environ:
    lvl = os.environ['STARTUP_LOGLVL'].upper()
    try:
        ch.setLevel(int(lvl))
    except ValueError:
        ch.setLevel(lvl)

    if ch.level <= 10:
        ch.setFormatter(ColoredFormatter('{levelname} [{name}] {message}', style='{'))
else:
    ch.setLevel(logging.INFO)

log = logging.getLogger('startup')
log.setLevel(logging.DEBUG)
log.addHandler(ch)
log.setConsoleLevel = ch.setLevel
log.setConsoleColor = ch.formatter.setColor
