from dotbot_conditional import Condition
from dotbot.messenger import Messenger

class Tester(object):

    def __init__(self, context):
        self._context = context
        self._log = Messenger()
        self.__load_conditions()

    def __load_conditions(self):
        self._plugins = [plugin(self._context) for plugin in Condition.__subclasses__()]

    def evaluate(self, tests):
        normalized = self.normalize_tests(tests)

        for task in normalized:
            for action in task:
                plugin = self.find_plugin(action)
                if plugin is not None:
                    try:
                        local_success = plugin.handle(action, task[action])
                        if not local_success:
                            return False
                    except Exception as err:
                        self._log.error("Failed to evaluate condition %s with value(s) %s" % (action, task[action]))
                        # Propogate the error since we don't know what to do
                        raise err
                    continue
        return True

    def find_plugin(self, directive):
        for plugin in self._plugins:
            if plugin.can_handle(directive):
                return plugin
        return None

    def normalize_tests(self, tests):
        if isinstance(tests, str):
            return [ { 'shell': tests } ]
        elif isinstance(tests, dict):
            return [ tests ]
        elif isinstance(tests, list):
            return map(lambda test: { 'shell': test } if isinstance(test, str) else test, tests)
        else:
            raise ValueError("Unable to handle conditions of type: %s" % type(tests))
