#!/usr/bin/env bash

set -e # Terminate script if anything exits with a non-zero value

print() {
  local fmt="$1"; shift

  # shellcheck disable=SC2059
  printf "\n[BOOTSTRAP] $fmt\n" "$@"
}

# Make sure we're on Linux before continuing
osName=$(uname)

if [[ "$osName" != 'Linux' ]]; then
  print "Oops, it looks like you're using a non-supported OS. Exiting"
  exit 1
fi

# 1. Installing basic tools
print "Installing basic tools"

print "Installing build-essential"
sudo apt-get install -y build-essential

print "Installing curl"
sudo apt-get install -y curl

print "Installing git"
sudo apt-get install -y git

print "Installing Vim"
sudo apt-get install -y vim

print "Installing htop"
sudo apt-get install -y htop

print "Installing tree"
sudo apt-get install -y tree

print "Installing zsh"
sudo apt-get install -y zsh

print "Installing Node Version Manager"
export NVM_DIR="$HOME/.nvm" && (
  git clone https://github.com/nvm-sh/nvm.git "$NVM_DIR"
  cd "$NVM_DIR"
  git checkout $(git describe --abbrev=0 --tags --match "v[0-9]*" $(git rev-list --tags --max-count=1))
) && \. "$NVM_DIR/nvm.sh"

print "Installing lts version of node via NVM"
nvm install --lts

# 2. Cloning dotfiles repository
print "Setup dotfiles"

DOTFILES_REPO_URL="https://github.com/m-sureshraj/dotfiles"
DOTFILES_DIR=$HOME/dotfiles

if [ -d "$DOTFILES_DIR" ]; then
  print "Removing old $DOTFILES_DIR directory"
  rm -rf "$DOTFILES_DIR"
fi

print "Cloning dotfiles repository"
git clone $DOTFILES_REPO_URL "$DOTFILES_DIR"

# shellcheck source=/dev/null
source "$DOTFILES_DIR"/link.dotfiles.sh

# 3. Setup Vim
print "Setup Vim"

VIM_DIR=$HOME/.vim
VIM_COLOR_SCHEME_REPO_URL="https://github.com/blueshirts/darcula.git"

print "Cloning $VIM_COLOR_SCHEME_REPO_URL repository"
git clone $VIM_COLOR_SCHEME_REPO_URL "$HOME"/darcula

if [ ! -d "$VIM_DIR" ]; then
  print "Creating $VIM_DIR in $HOME"
  mkdir -p "$VIM_DIR"
fi

print "Copying darcula color scheme into $VIM_DIR/colors"
cp -r "$HOME"/darcula/colors "$VIM_DIR"

print "Removing darcula color scheme repo"
rm -rf "$HOME"/darcula

echo "**** Bootstrap script complete! Please restart your computer. ****"

# Todo install oh-my-zsh
#print "Installing oh-my-zsh"
#
#if [ -d "$HOME"/.oh-my-zsh ]; then
#  rm -rf "$HOME"/.oh-my-zsh
#fi
#
#git clone git://github.com/robbyrussell/oh-my-zsh.git "$HOME"/.oh-my-zsh
#
#print "Changing your shell to zsh"
#chsh -s "$(command -v zsh)"