#!/usr/bin/env sh


# for both linux and macos



#Install poetry
zsh $(curl -sSL https://install.python-poetry.org | python3 - )
poetry completions zsh > ~/.zfunc/_poetry


curl -L https://github.com/techjacker/repo-security-scanner/releases/download/0.4.1/repo-security-scanner_0.4.1_Darwin_arm64.tar.gz -o ~/.local/bin/repo-security-scanner.tar.gz
tar -xf ~/.local/bin/repo-security-scanner.tar.gz


curl -LsSf https://astral.sh/uv/install.sh | sh