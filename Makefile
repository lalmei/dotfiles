.DEFAULT_GOAL = help

dotbot_dir := dotbot
dotbot_plugin_dir = $(shell find . -maxdepth 1 -type d -name "dotbot-*")
dotbot_bin := bin/dotbot


SHELL := zsh
base_dir := $(shell dirname $(realpath $(firstword $(MAKEFILE_LIST))))
config := install.conf.json

.PHONY: help
help: ## Print the help screen.
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":|:[[:space:]].*?##"}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'


run:  $(config) sync-dotbot links shell brewfile # run full install


.PHONY: sync-dotbot
sync-dotbot: ## Sync the dotbot submodule.
	git -C "${dotbot_dir}" submodule sync --quiet --recursive
	git submodule update --init --recursive "${dotbot_dir}"

.PHONY: links
links: ## Create symlinks for dotfiles.
	${dotbot_dir}/${dotbot_bin} -d "$(base_dir)" --plugin-dir "${dotbot_plugin_dir}/*" -c "${config}" --only link

.PHONY: shell
shell: ## Run shell commands.
	${dotbot_dir}/${dotbot_bin} -d "$(base_dir)" --plugin-dir "${dotbot_plugin_dir}/*" -c "${config}" --only shell

.PHONY: brewfile
brewfile: ## Run brewfile commands.
	${dotbot_dir}/${dotbot_bin} -d "$(base_dir)" --plugin-dir "${dotbot_plugin_dir}/*" -c "${config}" --only brewfile

.PHONY: clean
clean: ## Clean symlinks for dotfiles.
	${dotbot_dir}/${dotbot_bin} -d "$(base_dir)" --plugin-dir "${dotbot_plugin_dir}/*" -c "${config}" --only clean
