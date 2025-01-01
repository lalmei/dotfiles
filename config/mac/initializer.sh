#!/usr/bin/env sh

# sudo -v

# # Keep-alive: update existing `sudo` time stamp until `.macos` has finished
# while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &


#install brew if not present
command -v brew >/dev/null || /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

command -v brew bundle >/dev/null || brew install bundle
command -v mas >/dev/null || brew install mas




#Install poetry
zsh $(curl -sSL https://install.python-poetry.org | python3 - )
poetry completions zsh > ~/.zfunc/_poetry


curl -L https://github.com/techjacker/repo-security-scanner/releases/download/0.4.1/repo-security-scanner_0.4.1_Darwin_arm64.tar.gz -o ~/.local/bin/repo-security-scanner.tar.gz
tar -xf ~/.local/bin/repo-security-scanner.tar.gz

#sketchybar lua config
(git clone https://github.com/FelixKratz/SbarLua.git /tmp/SbarLua && cd /tmp/SbarLua/ && make install && rm -rf /tmp/SbarLua/)