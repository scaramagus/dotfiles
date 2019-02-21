#!/bin/bash

#Not interactive then nothing to load!
[ -z "$PS1" ] && return

DOTFILES=$(dirname $(readlink -f "${BASH_SOURCE[0]}"))

source_file() {
  if [ -f $1 ]; then
    command source $1
  fi
}

source_file "/etc/bash_completion"
source_file "$DOTFILES/aliases.sh"

# Load dependencies and custom config
for FILE in $(find "$DOTFILES/extra/" -maxdepth 1 -type f ! -name "*.disable")
do
  source $FILE
done

source_file "$HOME/.scm_breeze/scm_breeze.sh"
source_file "$HOME/.fzf.bash"

export PATH="$HOME/.pyenv/bin:$PATH"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"
export PYENV_VIRTUALENV_DISABLE_PROMPT=1
export VIRTUAL_ENV_DISABLE_PROMPT=1

export PATH="$HOME/neovim/bin:$PATH"
export PATH="$HOME/.poetry/bin:$PATH"
export PATH="$PATH:~/.local/bin"

source_file "$DOTFILES/prompt.sh"

export NVM_DIR="$HOME/.nvm"
source_file "$NVM_DIR/nvm.sh"
source_file "$NVM_DIR/bash_completion"


#Per machine configuration, we dont share this
source_file "$HOME/.bash_local"
