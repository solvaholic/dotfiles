#!/bin/sh
#
# OS
#
# These perform OS-specific install and configure tasks.
#

# TODO: Make this actually work.

# Figure out which OS and package manager we have, and call its script.

MYOS="$( sh "$(dirname $0)/../bin/whichos" )"

case $MYOS in
  Linux)
    if test $(which apt)
    then
      # We think we're running a Debian-based Linux, like Linux Mint.
      sh "$(dirname $0)/apt-install.sh"
    elif test $(which yum)
    then
      # We think we're running a RedHat-based Linux, like CentOS.
      sh "$(dirname $0)/yum-install.sh"
    fi
    ;;
  MacOS)
    sh "$(dirname $0)/mac-install.sh"
    ;;
  OpenBSD)
    sh "$(dirname $0)/obsd-install.sh"
    ;;
  *)
    ;;
esac
