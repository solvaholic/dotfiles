#!/bin/sh

set -e

# TODO: Check to make sure we were run from script/install.

# TODO: Install the default package list.

# Update installed packages and check for available patches.
# Thank you @nixcraft! https://www.cyberciti.biz/faq/howto-apply-updates-on-openbsd-operating-system/
# TODO: Make sure /etc/installurl contains a valid path, handle when it doesn't.
echo "> doas pkg_add -Uu"
doas pkg_add -Uu
echo " "
# TODO: If patches are available then explain how to install them.
echo "> doas syspatch -c"
doas syspatch -c

exit 0
