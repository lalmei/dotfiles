import dotbot
from dotbot.dispatcher import Dispatcher
from dotbot_conditional.tester import Tester

class Conditional(dotbot.Plugin):

    '''
    Conditionally execute nested commands based on the result of configured test(s)
    '''

    _directive = "conditional"

    def can_handle(self, directive):
        return directive == self._directive

    def handle(self, directive, data):
        if not self.can_handle(directive):
            raise ValueError("%s cannot handle directive %s" % (self.__class__.__name__, directive))
        return self._process_conditional(data)

    def _process_conditional(self, data):
        tests = data.get("if")
        test_result = Tester(self._context).evaluate(tests)
        self._log.debug("Condition %s evaluated to %s" % (tests, test_result))

        tasks = data.get("then") if test_result else data.get("else")

        if tasks is not None:
            defaults = self._context.defaults().get(self._directive, {})
            isolated_default = defaults.get('isolated', False)
            isolated = data.get('isolated', isolated_default) if isinstance(data, dict) else isolated_default

            dispatcher = self._create_dispatcher(isolated)
            return self._execute_nested(dispatcher, tasks)
        else:
            return True

    def _create_dispatcher(self, isolated):
        dispatcher = Dispatcher(self._context.base_directory(),
                            only=self._context.options().only,
                            skip=self._context.options().skip,
                            options=self._context.options())
        if not isolated:
            # ugly hack...
            dispatcher._context = self._context
            for p in dispatcher._plugins:
                p._context = self._context

        return dispatcher

    def _execute_nested(self, dispatcher, data):
        # if the data is a dictionary, wrap it in a list
        data = data if type(data) is list else [ data ]
        return dispatcher.dispatch(data)
