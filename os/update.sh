#!/bin/sh
#
# OS
#
# These perform OS-specific update and configure tasks.
#

# TODO: Make this actually work.

# Figure out which OS and package manager we have, and call its script.

MYOS="$( sh "$(dirname $0)/../bin/whichos" )"

case $MYOS in
  Linux)
    if test $(which apt)
    then
      # We think we're running a Debian-based Linux, like Linux Mint.
      sh "$(dirname $0)/apt-update.sh"
    elif test $(which yum)
    then
      # We think we're running a RedHat-based Linux, like CentOS.
      sh "$(dirname $0)/yum-update.sh"
    fi
    ;;
  MacOS)
    sh "$(dirname $0)/mac-update.sh"
    ;;
  OpenBSD)
    sh "$(dirname $0)/obsd-update.sh"
    ;;
  *)
    ;;
esac
