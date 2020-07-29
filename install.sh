#!/bin/sh

# TODO: Add installation of other dependencies (nerdfonts, pyenv, nvm, etc)

create_link() {
  if [ ! -f $2 ]; then
    command ln -s $1 $2 && echo "Link to $1 created."
  else
    echo "Link to $1 already exists. Skipping..."
  fi
}

BASE_DIR=$(dirname $(readlink -f "${BASH_SOURCE[0]}"))

# Create symlinks
create_link "$BASE_DIR/zsh" ~/.zshrc
create_link "$BASE_DIR/gitconfig" ~/.gitconfig
create_link "$BASE_DIR/tmux.conf" ~/.tmux.conf
create_link "$BASE_DIR/alacritty.yml" ~/.alacritty.yml

# Copy neovim config file (a symlink won't do)
echo "Copying neovim config file..."
cp "$BASE_DIR/init.vim" ~/.config/nvim/init.vim

echo "Installation complete. Please reload your terminal :)"
