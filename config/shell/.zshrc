

# If not running interactively, don't do anything
[[ $- != *i* ]] && return


HISTSIZE=5000
SAVEHIST=5000
HISTFILE=~/.zsh_history


# Poetry (python package manager)
POETRY_HOME="${POETRY_HOME:=${HOME}/.local/share/pypoetry}"
POETRY_BINARY="${POETRY_BINARY:=${POETRY_HOME}/venv/bin/poetry}"
export PATH="$POETRY_HOME/bin:$PATH"

bindkey '^R' history-incremental-search-backward




# Use modern completion system



# autoload -U +X bashcompinit && bashcompinit
autoload -U +X compinit && compinit

zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' completer _expand _complete _correct _approximate
zstyle ':completion:*' format 'Completing %d'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' menu select=2
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=* l:|=*'
zstyle ':completion:*' menu select=long
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' use-compctl false
zstyle ':completion:*' verbose true



zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'

# Add local bin to path if it exists
[[ -d $HOME/.local/bin ]] && PATH="$PATH:$HOME/.local/bin"

# Load starship prompt if starship is installed:
command -v starship >/dev/null && eval "$(starship init zsh --print-full-init)"

# Load zoxide if installed:
command -v zoxide >/dev/null && eval "$(zoxide init zsh)"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Cargo config
[[ -f "$HOME/.cargo/env" ]] && source "$HOME/.cargo/env"

#Check if jq is installed
command -v jq >/dev/null || error_msg "Please install jq JSON parsing utility" 1
command -v eza >/dev/null || error_msg "Please install eza for a modern replacement of ls" 1

# Init custom scripts

# aliases
[[ -f "$HOME/.config/scripts/_aliases" ]] && source "$HOME/.config/scripts/_aliases"

# #secrets
# [[ -f "$HOME/.config/scripts/_secrets" ]] && source "$HOME/.config/scripts/_secrets"

# mac os
# [[ uname -s == "Darwin" ]] && [[ -f "$HOME/.config/scripts/mac"]] && source "$HOME/.config/scripts/mac/.macos"

#for compiling
export PATH="/opt/homebrew/opt/make/libexec/gnubin:$PATH"
export PATH="/opt/homebrew/opt/llvm/bin:$PATH"


export LDFLAGS="-L/opt/homebrew/opt/llvm/lib"
export CPPFLAGS="-I/opt/homebrew/opt/llvm/include"
