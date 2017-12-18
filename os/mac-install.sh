#!/bin/sh

set -e

# The Brewfile handles Homebrew-based app and library installs, but there may
# still be updates and installables in the Mac App Store. There's a nifty
# command line interface to it that we can use to just install everything, so
# yeah, let's do that.

# TODO: Decide whether to sudo softwareupdate.
# echo "› sudo softwareupdate -i -a"
# sudo softwareupdate -i -a

# If we don't have Homebrew yet, install it now.
sh "$(dirname $0)/../homebrew/install.sh"

# Run Homebrew through the Brewfile.
cd $(dirname $0)/..
echo "› brew bundle"
brew bundle

exit 0
