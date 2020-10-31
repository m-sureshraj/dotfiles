#!/usr/bin/env bash

set -e

print() {
  local msg="$1"; shift

  printf "[LINKING] %s\n" "$msg"
}

DOTFILES_DIR=$HOME/dotfiles
OLD_DOTFILES_DIR=$HOME/old_dotfiles

# list of files to symlink in homedir
files=('gitconfig' 'vimrc' 'zshrc')

print "Linking dotfiles..."

for file in "${files[@]}"; do
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

  print "→ Linking $DOTFILES_DIR/$file to $HOME/.$file"
  ln -nfs "$DOTFILES_DIR/$file" "$HOME/.$file"
done

print "Linking complete!"