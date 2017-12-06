#!/bin/sh
#
# Homebrew
#
# This installs Homebrew, if MacOS.

# Check for Homebrew
if test ! $(which brew)
then

  if test "$(uname)" = "Darwin"
  then
    echo "  Installing Homebrew for you."
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
  fi

fi

exit 0
