#!/usr/bin/env bash

print() {
  local fmt="$1"; shift

  # shellcheck disable=SC2059
  printf "\n[BOOTSTRAP] $fmt\n" "$@"
}

################################################################################
# Variable declarations
################################################################################

osName=$(uname)

################################################################################
# Make sure we're on Linux before continuing
################################################################################

if [[ "$osName" != 'Linux' ]]; then
  print "Oops, it looks like you're using a non-supported OS. Exiting..."
  exit 1
fi

################################################################################
# 1. Update the system.
################################################################################

print "Step 1: Updating system packages..."

if command -v aptitude >/dev/null; then
  print "Using aptitude..."
else
  print "Installing aptitude..."
  sudo apt-get install -y aptitude
fi

sudo aptitude update
sudo aptitude -y upgrade

################################################################################
# 2. Install basic tools
################################################################################

print "Step 2: Installing basic tools..."
sudo aptitude install -y build-essential

print "Installing curl ..."
sudo aptitude install -y curl

print "Installing git ..."
sudo aptitude install -y git

print "Installing Vim ..."
sudo aptitude install -y vim

print "Installing htop ..."
sudo aptitude install -y htop

print "Installing tree ..."
sudo aptitude install -y tree

print "Installing zsh ..."
sudo aptitude install -y zsh

# https://github.com/nvm-sh/nvm#manual-install
print "Installing node via NVM ..."
export NVM_DIR="$HOME/.nvm" && (
  git clone https://github.com/nvm-sh/nvm.git "$NVM_DIR"
  cd "$NVM_DIR"
  git checkout "git describe --abbrev=0 --tags --match "v[0-9]*" $(git rev-list --tags --max-count=1)"
) && \. "$NVM_DIR/nvm.sh"

nvm install --lts

################################################################################
# 3. Setup dotfiles
################################################################################

print "Step 3: Setup Dotfiles..."

PATH_TO_DOT_FILES=$HOME/dotfiles/link.dotfiles.sh

# shellcheck source=/dev/null
source "$PATH_TO_DOT_FILES"

################################################################################
# 4. Setup Vim
################################################################################

print "Step 4: Setup Vim..."

git clone https://github.com/blueshirts/darcula "$HOME"
cp "$HOME"/darcula/colors/darcula.vim "$HOME"/.vim/colors/
rm -rf "$HOME"/darcula
