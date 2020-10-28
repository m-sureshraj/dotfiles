#!/usr/bin/env bash

OH_MY_ZSH_PATH=$HOME/.oh-my-zsh
PLUGINS_PATH=$OH_MY_ZSH_PATH/custom/plugins

print() {
  local fmt="$1"; shift

  # shellcheck disable=SC2059
  printf "\n[OH-MY-ZSH] $fmt\n" "$@"
}

if [ -d "$OH_MY_ZSH_PATH" ]; then
  print "Removing existing $HOME/.oh-my-zsh directory"
  rm -rf "$OH_MY_ZSH_PATH"
fi

sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --keep-zshrc

# install plugins
print "Installing zsh-autosuggestions plugin"
git clone https://github.com/zsh-users/zsh-autosuggestions "$PLUGINS_PATH"/zsh-autosuggestions

print "Installing Cobalt2 theme"
wget https://raw.githubusercontent.com/wesbos/Cobalt2-iterm/master/cobalt2.zsh-theme -P "$OH_MY_ZSH_PATH"/themes

#https://github.com/jjangga0214/.dotfiles.oh-my-zsh/blob/master/install.sh