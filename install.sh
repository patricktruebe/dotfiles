#!/usr/bin/env bash
set -e

# Get current dir (so run this script from anywhere)

export DOTFILES_DIR EXTRA_DIR
DOTFILES_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" > /dev/null && pwd )"
EXTRA_DIR="$HOME/.extra"

# Update dotfiles itself first

[ -d "$DOTFILES_DIR/.git" ] && git --work-tree="$DOTFILES_DIR" --git-dir="$DOTFILES_DIR/.git" pull origin master

# Bunch of symlinks


echo -n "Updating bashrc ..."
if ! grep -q ". $DOTFILES_DIR/runcom/.bash_profile" "$HOME/.bashrc" ; then
  echo "[ -s $DOTFILES_DIR/runcom/.bash_profile ] && . $DOTFILES_DIR/runcom/.bash_profile" >> "$HOME/.bashrc"
  echo -n "done"
fi
echo
ln -sfv "$DOTFILES_DIR/runcom/.bash_profile" ~
ln -sfv "$DOTFILES_DIR/runcom/.inputrc" ~
ln -sfv "$DOTFILES_DIR/runcom/.gemrc" ~
ln -sfv "$DOTFILES_DIR/git/.gitconfig" ~
ln -sfv "$DOTFILES_DIR/git/.gitignore_global" ~

# Package managers & packages

if [ "$(uname)" == "Linux" -a "$(lsb_release -is)" == "Fedora" ]; then
  . "$DOTFILES_DIR/install/fedora.sh"
fi

. "$DOTFILES_DIR/install/npm.sh"
. "$DOTFILES_DIR/install/pip.sh"

if [ "$(uname)" == "Darwin" ]; then
  . "$DOTFILES_DIR/install/brew.sh"
  . "$DOTFILES_DIR/install/bash.sh"
  . "$DOTFILES_DIR/install/brew-cask.sh"
  . "$DOTFILES_DIR/install/gem.sh"
  ln -sfv "$DOTFILES_DIR/etc/mackup/.mackup.cfg" ~
fi

# Run tests

source $HOME/.bashrc
bats $DOTFILES_DIR/test/*.bats

# Install extra stuff

if [ -d "$EXTRA_DIR" -a -f "$EXTRA_DIR/install.sh" ]; then
  . "$EXTRA_DIR/install.sh"
fi
