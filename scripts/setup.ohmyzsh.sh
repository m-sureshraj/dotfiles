#!/usr/bin/env bash

set -e

print() {
  printf "\n[OH-MY-ZSH] %s\n" "$1"
}

OH_MY_ZSH_PATH=$HOME/.oh-my-zsh
PLUGINS_PATH=$OH_MY_ZSH_PATH/custom/plugins

if [ -d "$OH_MY_ZSH_PATH" ]; then
  print "Removing existing $HOME/.oh-my-zsh directory"
  rm -rf "$OH_MY_ZSH_PATH"
fi

sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --keep-zshrc --unattended

print "Installing zsh-autosuggestions plugin"
git clone https://github.com/zsh-users/zsh-autosuggestions "$PLUGINS_PATH"/zsh-autosuggestions

print "Downloading Cobalt2 theme"
wget https://raw.githubusercontent.com/wesbos/Cobalt2-iterm/master/cobalt2.zsh-theme -P "$OH_MY_ZSH_PATH"/themes

print "Changing shell to zsh"
chsh -s "$(command -v zsh)"
