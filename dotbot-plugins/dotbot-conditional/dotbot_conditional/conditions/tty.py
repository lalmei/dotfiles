from dotbot_conditional import Condition

import sys

class TtyCondition(Condition):

    """
    Condition testing if stdin is a TTY (allowing to request input from the user)
    """

    _directive = "tty"

    def can_handle(self, directive):
        return directive == self._directive

    def handle(self, directive, data=True):
        if not self.can_handle(directive):
            raise ValueError("%s cannot handle directive %s" % (self.__class__.__name__, directive))

        expected = data if data is not None else True
        return expected == (sys.stdin.isatty() and sys.stdout.isatty() and sys.stderr.isatty())
