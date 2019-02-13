#!/bin/bash

# TODO: Add installation of other dependencies (nerdfonts, pyenv, nvm, etc)

BASE_DIR=$(dirname $(readlink -f "${BASH_SOURCE[0]}"))

create_link() {
  if [ ! -f $2 ]; then
    command ln -s $1 $2 && echo "Link to $1 created."
  else
    echo "Link to $1 already exists. Skipping..."
  fi
}

# Create symlinks
create_link "$BASE_DIR/bash_profile.sh" ~/.bash_profile
create_link "$BASE_DIR/gitconfig" ~/.gitconfig
create_link "$BASE_DIR/.tmux.conf" ~/.tmux.conf

# Copy neovim config file
echo "Copying neovim config file..."
cp "$BASE_DIR/init.vim" ~/.config/nvim/init.vim

# Add .bash_profile to .bashrc
SOURCE_CMD='[ -n "$PS1" ] && source "$HOME/.bash_profile"'
if ! grep -q "$SOURCE_CMD" ~/.bashrc; then
  echo "$SOURCE_CMD" >> ~/.bashrc && echo "Added .bash_profile source to .bashrc."
fi

echo "Installation complete. Please reload your terminal :)"
