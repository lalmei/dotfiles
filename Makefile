.DEFAULT_GOAL = run

dotbot_dir := dotbot
dotbot_plugin_dir = $(shell find . -maxdepth 1 -type d -name "dotbot-*")
dotbot_bin := bin/dotbot


SHELL := zsh
base_dir := $(shell dirname $(realpath $(firstword $(MAKEFILE_LIST))))
config := install.conf.json


run:  $(config) sync-dotbot links shell brewfile # run full install


.PHONY: sync-dotbot
sync-dotbot:
	git -C "${dotbot_dir}" submodule sync --quiet --recursive
	git submodule update --init --recursive "${dotbot_dir}"

.PHONY: links
links:
	${dotbot_dir}/${dotbot_bin} -d "$(base_dir)" --plugin-dir "${dotbot_plugin_dir}/*" -c "${config}" --only link

.PHONY: shell
shell:
	${dotbot_dir}/${dotbot_bin} -d "$(base_dir)" --plugin-dir "${dotbot_plugin_dir}/*" -c "${config}" --only shell

.PHONY: brewfile
brewfile:
	${dotbot_dir}/${dotbot_bin} -d "$(base_dir)" --plugin-dir "${dotbot_plugin_dir}/*" -c "${config}" --only brewfile

.PHONY: clean
clean:
	${dotbot_dir}/${dotbot_bin} -d "$(base_dir)" --plugin-dir "${dotbot_plugin_dir}/*" -c "${config}" --only clean
