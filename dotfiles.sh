#!/bin/sh

#
# Define re-usable functions for dotfiles shell scripts.
#
# - dotfiles.sh: Define variables and functions for dotfiles scripts.
#
# Usage:
#   . "$DOTFILES_ROOT/dotfiles.sh"
#
# This file must be in the root of the dotfiles installation,
# typically ~/.dotfiles.
#

# shellcheck disable=SC2039

# Define some output functions.

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

debug () {
  if [ -n "$DOTFILES_DEBUG" ] && [ "$DOTFILES_DEBUG" -ne 0 ]; then
    printf "\r  [ \033[0;33m==\033[0m ] %s\n" "$1" >&2
  fi
}

#
# Define check_preq() function for ensuring prerequisites are met.
#
check_preq () {
  _self="${_self:-:}"
  _result=0
  info "$_self: Check for prerequisites."
  # COMMANDS
  for _cmd in id docker; do
    if command -v "$_cmd" >/dev/null; then
      debug "$_self: check_preq() found command '$_cmd' OK."
    else
      fail "$_self: check_preq() did not find command '$_cmd'."
      _result=$_result+1
    fi
  done
  # PATH ELEMENTS
  # shellcheck disable=SC2066
  for _path in "$HOME/Local/bin"; do
    if [[ ":$PATH:" = *":$_path:"* ]] ; then
      debug "$_self: check_preq() found '$_path' in \$PATH OK."
    else
      fail "$_self: check_preq() did not find '$_path' in \$PATH."
      _result=$_result+1
    fi
  done
  return $((_result))
}

#
# Define can_i_sudo() function for testing sudo access.
#
can_i_sudo () {
  user "Checking whether you can sudo. You may be asked to enter your password."
  if [ -x "$(command -v sudo)" ]; then
    if sudo -v; then
      info "Alright! You're good to go."
      return 0
    else
      info "That didn't work. Check your sudo config."
      return 1
    fi
  else
    info "Did not find sudo. Please install and configure it."
    return 1
  fi
}

#
# Define run_as_root() function.
#
run_as_root () {
  if [ -z "$1" ]; then
    debug "$0: run_as_root() called with empty command."
    return 1
  fi
  _mycmd="$1"
  debug "$0: Attempting to run as root:"
  debug "  $_mycmd"
  if [ "$(id -u)" = "0" ]; then
    debug "$0: We are root, so just 'bash -c \"\$_mycmd\"'."
    bash -c "$_mycmd"
    return
  else
    if can_i_sudo; then
      debug "$0: We can sudo, so 'sudo bash -c \"\$_mycmd\"'."
      user "Attempting to run the command below;"
      user "You may be asked for your password:"
      info "  sudo bash -c \"$_mycmd\""
      sudo bash -c "$_mycmd"
      return
    else
      debug "We're not root, and we can't sudo. Sorry, boss."
      return 1
    fi
  fi
}

#
# Define link_file() function for creating symlinks.
#
link_file () {
  # Take $source and $target as parameters. Create a link ($target) to
  # $source. If $target already exists but is _not_ a link to $source
  # then ask the user what to do.

  source="$1" target="$2"
  overwrite='' backup='' skip='' action=''
  script_name="link_file()"

  # Do $source and $target look like valid paths?
  if [ ! -d "$( dirname "$target" )" ]; then
    # target path looks wrong
    fail "$script_name: \$target '$target' path is invalid!"
    return 1
  elif [ "${source:0:1}" = "/" ]; then
    debug "$script_name: \$source '$source' is an absolute path."
    if [ ! -e "$source" ]; then
      fail "$script_name: \$source '$source' doesn't exist!"
      return 1
    fi
  elif [ -n "$source" ]; then
    debug "$script_name: \$source '$source' is a relative path."
    pushd "$( dirname "$target" )" >/dev/null || return 1
    if [ ! -e "$source" ]; then
      fail "$script_name: \$source '$source' doesn't exist!"
      return 1
    fi
    popd >/dev/null || return 1
  else
    # Something is wrong.
    fail "$script_name: Shit broke yo."
    return 1
  fi

  # If $target already exists then prompt the user for action.
  if [ -e "$target" ]; then

    if [ -L "$target" ]; then
      # $target is a link. What's it point to?
      currentSrc="$(readlink "$target")"
      debug "$script_name: '$target' is a symlink to '$currentSrc'."
    else
      currentSrc=''
    fi

    # If $target is already a link to $source then assume "[s]kip".
    if [ -n "$currentSrc" ] && [ "$currentSrc" = "$source" ]; then
      debug "$script_name: '$currentSrc' matches \$source."
      skip="true"
    else

      user "File already exists: '$target'"
      user "  --> '$source'"
      user "What do you want to do?"

      # TODO: Validate input here.

      user "[s]kip, [o]verwrite?"
      read -r action

      case "$action" in
        o )
          overwrite="true";;
        s )
          skip="true";;
        * )
          ;;
      esac

    fi

  fi

  # TODO: Does the script need these 3 lines? :point_down:
  overwrite=${overwrite:-$overwrite_all}
  backup=${backup:-$backup_all}
  skip=${skip:-$skip_all}

  if [ "$skip" = "true" ]; then
    success "$script_name: Link '$target' is present."
  fi

  if [ "$skip" != "true" ]; then
    ln -f -s "$source" "$target"
    success "$script_name: Linked '$target' --> '$source'."
  fi
}
