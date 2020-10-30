#!/usr/bin/env bash

print() {
  local fmt="$1"; shift

  # shellcheck disable=SC2059
  printf "\n[DOTFILES] $fmt\n" "$@"
}

set -e # Terminate script if anything exits with a non-zero value
#set -u # Prevent unset variables

DOTFILES_DIR=$HOME/dotfiles
OLD_DOTFILES_DIR=$HOME/old_dotfiles
files="gitconfig vimrc zshrc" # list of files to symlink in homedir

print "Linking dotfiles..."

for file in $files; do
  if [ -f "$HOME/.$file" ]; then
    if [ ! -d "$OLD_DOTFILES_DIR" ]; then
      print "Creating $OLD_DOTFILES_DIR to backup matched dotfiles in $HOME"
      mkdir -p "$OLD_DOTFILES_DIR"
    fi

    print "Moving .$file to $OLD_DOTFILES_DIR"
    cp "$HOME/.$file" "$OLD_DOTFILES_DIR/.$file"

    print "Removing $HOME/.$file"
    rm -f "$HOME/.$file"
  fi

  print "-> Linking $DOTFILES_DIR/$file to $HOME/.$file"
  ln -nfs "$DOTFILES_DIR/$file" "$HOME/.$file"
done

print "Linking complete!"