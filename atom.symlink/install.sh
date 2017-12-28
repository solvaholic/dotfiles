#!/bin/sh
#
# Atom installer
#
# Install or upgrade Atom (https://atom.io)
#

set -e

# Currently only works for dpkg-based Linux distributions!
if [ ! -n "$( which dpkg )" ]; then
  echo "STOP: This currently only works for dpkg-based Linux distributions."
  exit 1
fi

# TODO: Wrap these in a whichos and stub other package managers' methods.
# TODO: Find an effective way to test the new/installed versions.

echo "Downloading the newest release of Atom..."
# Remove any leftover /tmp/atom.deb and download the newest release.
rm -f /tmp/atom.deb
curl -sLo /tmp/atom.deb https://atom.io/download/deb

if [ -n "$( dpkg -I /tmp/atom.deb | egrep -o 'Version: .+$' )" ]; then
  # Assume the downloaded .deb is valid, grab its version and continue.
  NEWVER="$( dpkg -I /tmp/atom.deb | egrep -o 'Version: .+$' )"
  echo "Atom $NEWVER is the newest release."
else
  # Assume the downloaded .deb is not valid, and exit.
  echo "STOP: Unable to determine version of /tmp/atom.deb!"
  exit 1
fi

if [ -n "$( dpkg -s atom | egrep -o 'Version: .+$' )" ]; then
  # Atom is currently installed, so grab its version and continue.
  CURVER="$( dpkg -s atom | egrep -o 'Version: .+$' )"
  echo "Atom $CURVER is currently installed."
fi

# TODO: Is it possible to reach this point with bad NEWVER or CURVER?
#       And find a more robust way to compare versions. This failed.

if [ "$NEWVER" > "$CURVER" ]; then
  # NEWVER is greater than CURVER, so uninstall old and install new.
  echo "Uninstalling Atom $CURVER..."
  echo "> sudo dpkg -r atom"
  sudo dpkg -r atom
  echo "Installing Atom $NEWVER..."
  echo "> sudo dpkg -i /tmp/atom.deb"
  sudo dpkg -i /tmp/atom.deb
else
  # NEWVER is less than or equal to CURVER, so pass.
  echo "It looks like you're already running the latest. Good job!"
fi
