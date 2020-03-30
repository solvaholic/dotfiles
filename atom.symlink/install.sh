#!/bin/sh
#
# Atom installer
#
# - atom.symlink/install.sh: Install or upgrade Atom (https://atom.io).
#
#     - If Atom is already installed, which version?
#     - Download the latest release of Atom.
#     - If the download is newer than the installed version, upgrade.
#
# Usage:
#   ./atom.symlink/install.sh
#


# Load ~/.dotfiles.conf and $DOTFILES_ROOT/dotfiles.sh.
# shellcheck disable=SC1090
{
  . ~/.dotfiles.conf || exit
  . "$DOTFILES_ROOT/dotfiles.sh" || exit
} \
&& debug "$0: Loaded ~/.dotfiles.conf and ran $DOTFILES_ROOT/dotfiles.sh OK." \
|| exit


# Currently only works for dpkg-based Linux distributions.
if [ -z "$( command -v dpkg )" ]; then
  fail "$): This currently only works for dpkg-based Linux distributions."
  exit 1
fi


# TODO: Wrap these in a whichos and stub other package managers' methods.
# TODO: Find an effective way to test the new/installed versions.


# If Atom is already installed, which version?
if [ -x "$( command -v atom )" ]; then
  # Looks like Atom is installed.
  _curver=$(atom -v | sed -n '/^Atom/ s/^.*: \(.*\)$/\1/p') \
  && debug "$0: Atom $_curver is currently installed." \
  || exit
else
  # Looks like Atom is not installed.
  _curver=$(atom -v | sed -n '/^Atom/ s/^.*: \(.*\)$/\1/p') \
  && debug "$0: Atom $_curver is currently installed." \
  _curver=""
fi


# Download the latest release of Atom.
debug "$0: Downloading the latest release of Atom..."
# Remove any leftover /tmp/atom.deb and download the latest release.
rm -f /tmp/atom.deb
curl -sLo /tmp/atom.deb https://atom.io/download/deb


# If the download is newer than the installed version, upgrade.
_newver=""
_newver="$( dpkg -I /tmp/atom.deb | sed -n '/Version/ s/^.*: \(.*\)$/\1/p' )" \
|| exit

if [ -n "$_newver" ]; then
  # Assume the downloaded .deb is valid, grab its version and continue.
  debug "$0: Downloaded Atom $_newver."
else
  # Assume the downloaded .deb is not valid, and exit.
  fail "$0: Unable to determine version of /tmp/atom.deb."
  exit 1
fi

info "$0: The latest release of Atom is $_newver."
info "$0: Looks like you have Atom $_curver installed."


# TODO: Find a more robust way to compare versions. This failed.

_winner="$( (echo "$_curver"; echo "$_newver") | sort -nr - | head -n 1 )"

if [ "$_newver" = "$_winner" ] && [ "$_newver" != "$_curver" ]; then
  # _newver is greater than _curver, so uninstall old and install new.
  info "Uninstalling Atom $_curver..."
  info "> sudo dpkg -r atom"
  sudo dpkg -r atom
  info "Installing Atom $_newver..."
  info "> sudo dpkg -i /tmp/atom.deb"
  sudo dpkg -i /tmp/atom.deb
else
  # _newver is less than or equal to _curver, so pass.
  ifno "$0: Looks like you're already running the latest. Good job!"
fi
