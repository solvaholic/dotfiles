#!/bin/sh
#
# Defaults and functions for `dotfiles` scripts.
#
# This file must be in the root of the `dotfiles` installation,
# typically `~/.dotfiles`.
#

# Define some reusable functions.

info () {
  printf "\r  [ \033[00;34m..\033[0m ] %s\n" "$1"
}

user () {
  printf "\r  [ \033[0;33m??\033[0m ] %s\n" "$1"
}

success () {
  printf "\r\033[2K  [ \033[00;32mOK\033[0m ] %s\n" "$1"
}

fail () {
  printf "\r\033[2K  [\033[0;31mFAIL\033[0m] %s\n" "$1"
  echo ''
}

# Set some configuration variables.

#
# DOTFILES_ROOT
#
if [ -f "$0" ] && [ $( dirname "$0" ) ]; then
  # $0 is a file and `dirname` succeeds, so we think we can use its path.
  DOTFILES_ROOT="$( cd $( dirname "$0" )/.. && echo $PWD )"
else
  # $0 is not a file or `dirname` fails, so we can't use its path.
  # This notices if we were called like `. ~/.dotfiles/dotfiles.sh`.
  # This may not notice if we were called from $PATH.
  DOTFILES_ROOT=
  fail "dotfiles/dotfiles.sh: This script was called incorrectly. Unable to set \$DOTFILES_ROOT."
  info "\$0 is '$0'."
  return 1
fi

#
# WHICHOS
#
if [ -x "$DOTFILES_ROOT/bin/whichos" ]; then
  WHICHOS="$( $DOTFILES_ROOT/bin/whichos )"
else
  WHICHOS=
  fail "dotfiles/dotfiles.sh: Can't find '$DOTFILES_ROOT/bin/whichos'. Unable to set \$WHICHOS."
  return 1
fi
