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
