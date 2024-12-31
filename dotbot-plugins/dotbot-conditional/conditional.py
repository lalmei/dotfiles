import os
import sys

from dotbot.messenger import Messenger

def add_module_to_path():
    path = os.path.join(os.path.dirname(os.path.realpath(__file__)))
    if path not in sys.path:
        sys.path.append(path)

add_module_to_path()

from dotbot_conditional import Conditional
from dotbot_conditional.conditions import ShellCondition
from dotbot_conditional.conditions import TtyCondition
