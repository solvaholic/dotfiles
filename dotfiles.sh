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

debug () {
  if [ -n "$DOTFILES_DEBUG" ] && [ "$DOTFILES_DEBUG" -ne 0 ]; then
    printf "\r  [ \033[0;33m##\033[0m ] %s\n" "$1" >&2
  fi
}

#
# Define link_file() function for creating symlinks.
#
link_file () {
  # Take $source and $target as parameters. Create a link ($target) to
  # $source. If $target already exists but is _not_ a link to $source
  # then ask the user what to do.

  local source="$1" target="$2" shortsource="${source#$HOME/}"
  local overwrite= backup= skip= action=
  local script_name="link_file()"
  
  # Do $source and $target look like valid paths? If not then return 1.
  if [ ! -e "$source" ]; then
    fail "$script_name: \$source '$source' doesn't exist!"
    return 1
  elif [ ! -d "$( dirname "$target" )" ]; then
    fail "$script_name: \$target '$target' path is invalid!"
    return 1
  fi

  # If the target already exists, then prompt the user for action.
  if [ -e "$target" ]; then

    # link_file() inherits overwrite_all, backup_all, and skip_all
    # from the caller.

    if [ "$overwrite_all" = "false" ] && [ "$backup_all" = "false" ] && [ "$skip_all" = "false" ]
    then

      if [ -h "$target" ]; then
        # Target is a link. What's it point to?
        local currentSrc="$(readlink $target)"
      else
        local currentSrc=
      fi

      # If $target is already a link to $shortsource then then assume "[s]kip".
      if [ ! -z "$currentSrc" ] && [ "$currentSrc" = "$shortsource" ]; then
        skip="true";
      else

        user "File already exists: $target ($(basename "$source"))"
        user "What do you want to do?"

        # TODO: Validate input here.

        user "[s]kip, [S]kip all, [o]verwrite, [O]verwrite all, [b]ackup, [B]ackup all?"
        read action

        case "$action" in
          o )
            overwrite="true";;
          O )
            overwrite_all="true";;
          b )
            backup="true";;
          B )
            backup_all="true";;
          s )
            skip="true";;
          S )
            skip_all="true";;
          * )
            ;;
        esac

      fi

    fi

    overwrite=${overwrite:-$overwrite_all}
    backup=${backup:-$backup_all}
    skip=${skip:-$skip_all}

    if [ "$overwrite" = "true" ]; then
      rm -rf "$target"
      success "$script_name: Removed '$target'."
    elif [ "$backup" = "true" ]; then
      mv "$target" "${target}.backup"
      success "$script_name: Moved '$target' to '${target}.backup'."
    elif [ "$skip" = "true" ]; then
      success "$script_name: '$target' is already installed."
    fi
  fi

  if [ "$skip" != "true" ]; then
    ln -s "$shortsource" "$target"
    success "$script_name: Linked '$source' to '$target'."
  fi
}
