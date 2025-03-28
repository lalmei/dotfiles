#!/usr/bin/env sh

# sudo -v

# # Keep-alive: update existing `sudo` time stamp until `.macos` has finished
# while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &


if [[ "$OSTYPE" == "darwin"* ]]; then
    command -v brew >/dev/null || NONINTERACTIVE=1 /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

    command -v brew bundle >/dev/null || brew install bundle
    command -v mas >/dev/null || brew install mas
fi




#Install poetry
command -v poetry >/dev/null || NONINTERACTIVE=1 zsh $(curl -sSL https://install.python-poetry.org | python3 - ) && poetry completions zsh > ~/.zfunc/_poetry

command -v nix-shell >/dev/null || NONINTERACTIVE=1 zsh $(curl -L https://nixos.org/nix/install | sh )

# curl -L https://github.com/techjacker/repo-security-scanner/releases/download/0.4.1/repo-security-scanner_0.4.1_Darwin_arm64.tar.gz -o ~/.local/bin/repo-security-scanner.tar.gz
# tar -xf ~/.local/bin/repo-security-scanner.tar.gz

# #sketchybar lua config
# (git clone https://github.com/FelixKratz/SbarLua.git /tmp/SbarLua && cd /tmp/SbarLua/ && make install && rm -rf /tmp/SbarLua/)