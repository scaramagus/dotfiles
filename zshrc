export ZSH="/home/agustin/.oh-my-zsh"

# ZSH Theme and plugins
ZSH_THEME="spaceship"
plugins=(docker docker-compose python sudo)

source $ZSH/oh-my-zsh.sh

export LANG="en_US.UTF-8"

export EDITOR='nvim'

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Pyenv settings
export PATH="$HOME/.pyenv/bin:$PATH"
export PYENV_VIRTUAL_DISABLE_PROMPT=1
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

# NVM settings
export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm

# Aliases and helpers for git
[ -s "/home/agustin/.scm_breeze/scm_breeze.sh" ] && source "/home/agustin/.scm_breeze/scm_breeze.sh"

# Attach or create tmux session named the same as current directory.
path_name="$(basename "$PWD" | tr . -)"
session_name=${1-$path_name}

not_in_tmux() {
  [ -z "$TMUX" ]
}

session_exists() {
  tmux list-sessions | sed -E 's/:.*$//' | grep -q "^$session_name$"
}

create_detached_session() {
  (TMUX='' tmux new-session -Ad -s "$session_name")
}

create_if_needed_and_attach() {
  if not_in_tmux; then
    tmux new-session -As "$session_name"
  else
    if ! session_exists; then
      create_detached_session
    fi
    tmux switch-client -t "$session_name"
  fi
}

create_if_needed_and_attach
