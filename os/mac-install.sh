#!/bin/sh

set -e

# The Brewfile handles Homebrew-based app and library installs, but there may
# still be updates and installables in the Mac App Store. There's a nifty
# command line interface to it that we can use to just install everything, so
# yeah, let's do that.

# TODO: Decide whether to sudo softwareupdate.
# echo "› sudo softwareupdate -i -a"
# sudo softwareupdate -i -a

if test ! $(which brew)
then
  # We already have Homebrew, so upgrade packages.
  echo "> brew upgrade"
  brew upgrade
else
  # We don't have Homebrew yet, so install it now.
  sh "$(dirname $0)/../homebrew/install.sh"
fi

# Run Homebrew through the Brewfile.
cd $(dirname $0)/..
echo "› brew bundle"
brew bundle

# Set macOS defaults
sh "$(dirname $0)/../macos/set-defaults.sh"

exit 0
