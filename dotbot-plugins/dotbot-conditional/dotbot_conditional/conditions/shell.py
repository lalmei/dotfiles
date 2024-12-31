from dotbot_conditional import Condition
import dotbot.util

class ShellCondition(Condition):

    """
    Condition testing an arbitrary shell command and evaluating to true if the return code is zero
    """

    _directive = "shell"

    def can_handle(self, directive):
        return directive == self._directive

    def handle(self, directive, data):
        if not self.can_handle(directive):
            raise ValueError("%s cannot handle directive %s" % (self.__class__.__name__, directive))
        ret = dotbot.util.shell_command(data, cwd=self._context.base_directory())
        return ret == 0
