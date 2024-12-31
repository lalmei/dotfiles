# dotbot-conditional

A directive providing control flow within a dotbot configuration file with conditions processed by python plugins.

## Installation

1. Add the plugin as a submodule to your dotfiles repository.
   `git submodule add https://gitlab.com/gnfzdz/dotbot-conditional.git ${dotbot_conditional_dir}`
2. Configure dotbot-conditional with an additional CLI argument when executing dotbot
   `... --plugin-dir ${dotbot_conditional_dir} ...`

## Options

Name | Description | Default
 --------| -------- | --------
if | The relative path to a dotbot configuration file that should be read and executed | N/A
then | Actions/tasks to execute if the condition evaluates to true | []
else | Actions/tasks to execute if the condition evaluates to false | []
isolated | A flag configuring whether defaults should be scoped to execution of the included file. Current defaults will not be considered when processing the file. Any defaults set within the configuration file will be discarded after processing the file is complete. | False

## Examples

```yaml

# Configururable defaults
- defaults:
    conditional:
        isolated: False

# Strings are interpreted as a shell command using the ShellCondition plugin
- conditional:
    if: 'command -v ansible-galaxy'
    then:
        shell:
        - ansible-galaxy install super.cool.collection

# In the below example, a single named condition is configured. When stdin, stdout, stderr are attached to a TTY, the plugin will execute a command that may prompt for user input. Otherwise, it will attempt to automate the commands execution.
- conditional:
    if:
        tty:
    then:
        shell:
        - command: termux-setup-storage
        description: Granting Termux access to shared storage
    else:
        shell:
        - command: echo y | termux-setup-storage
        description: Granting Termux access to shared storage


# A slightly more complex example showing multiple conditions (which must all be true) and a list of actions to execute
- conditional:
    if:
    - tty:
    - shell: "command -v git"
    - shell: "command -v make"
    then:
        - git:
            ~/Workspace/pathto/repo:
                url: 'https://github.com/pathto/repo.git'
        - shell:
          - 'cd ~/Workspace/pathto/repo && git apply some.patch && make install'

```

## Builtin Condition Plugins

### Shell
Conditional based on the return code of a provided shell command

```yaml

- conditional:
    if:
    # A string will automatically be evaulated with this plugin
    - "command -v git"
    # Or the more verbose format below can be used
    - shell: "command -v git-crypt"
    then:
    ...

```

### TTY
Conditional based on whether stdin, stdout and stderr are a TTY. The primary use case for this conditional is to determine if dotbot can safely execute commands that may prompt the user for input.

```yaml

# Tty doesn't require a value by default
- conditional:
    if:
    - tty:
    ...

# The below example inverts the condition
- conditional:
    if:
    - tty: False
    ...

```

### Other plugins

name | description
 --------| --------
[dotbot-gitcrypt](https://gitlab.com/gnfzdz/dotbot-gitcrypt) | Provides a condition based on whether target path(s) are currently locked as git-crypt encrypted files

## Creating custom condition plugins

1. Create a python file containing the plugin. Plugins are structured the same as dotbot directive plugins, but instead extend the Condition base class. You can find examples [here](https://gitlab.com/gnfzdz/dotbot-conditional/-/tree/main/dotbot_conditional/conditions)

2. Ensure that your plugin is loaded by dotbot AFTER dotbot-condition. Dotbot currently loads plugin directories (--plugin-dir) before individual plugin files (-p/--plugin). Make sure dotbot-condition is both configured with --plugin-dir AND before any condition plugins.
```sh
${dotbot_cmd} --plugin-dir path/to/dotbot-condition -p path/to/custom/plugin.py
```

## Credits
This plugin takes inspiration from the existing [ifplatform](https://github.com/ssbanerje/dotbot-ifplatform), [ifarch](https://github.com/ryansch/dotbot-ifarch) and [if](https://github.com/wonderbeyond/dotbot-if) plugins, intending to provide a more extensible solution. The condition plugin model and handling is based on the original plugin model in core [dotbot](https://github.com/anishathalye/dotbot). Thanks/credits to the original authors for each of the above.
