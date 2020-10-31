#!/usr/bin/env bash

# Terminate script if anything exits with a non-zero value
set -e

print() {
  printf "\n[BOOTSTRAP] %s\n" "$1"
}

# Make sure we're on Linux before continuing
osName=$(uname)

if [[ "$osName" != 'Linux' ]]; then
  print "Oops, The bootstrap script should be executed on a Linux OS."
  exit 1
fi

print "Updating package list"
sudo apt-get update

tools=('build-essential' 'curl' 'git' 'vim' 'htop' 'tree' 'zsh' 'fonts-powerline')

for tool in "${tools[@]}"
do
    print "Installing ${tool}"
    sudo apt-get install -y "$tool"
done

print "Installing Node Version Manager"
export NVM_DIR="$HOME/.nvm" && (
  git clone https://github.com/nvm-sh/nvm.git "$NVM_DIR"
  cd "$NVM_DIR"
  git checkout $(git describe --abbrev=0 --tags --match "v[0-9]*" $(git rev-list --tags --max-count=1))
) && \. "$NVM_DIR/nvm.sh"

print "Installing latest LTS release of Node.js through NVM"
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
source "$DOTFILES_DIR"/scripts/link.dotfiles.sh

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

# 4. Setup oh-my-zsh
print "Setup oh-my-zsh"

# shellcheck source=/dev/null
source "$DOTFILES_DIR"/scripts/setup.ohmyzsh.sh

echo "****************************************************************"
echo "Bootstrap script has been completed! Please restart the computer."
echo "****************************************************************"
