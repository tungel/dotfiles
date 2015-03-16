#!/usr/bin/env bash

# https://github.com/everbot/dotfiles
#
# This installation script is adapted from Holman's scripts
# ( https://github.com/holman/dotfiles )
# I only modified a small part of it to suit my usage. Basically, it is able to
# handle config files which are not supposed to be the direct children under ~
# directory. For example if you have config files under ~/.ssh then just create
# a directory .ssh in this repo. After this script is executed, the config files
# will be automatically symlinked with the correct path.
#

DOTFILES_ROOT=$(pwd)

# set -e

echo "Current working dir is: $DOTFILES_ROOT"

info () {
  printf "  [ \033[00;34m..\033[0m ] $1"
}

user () {
  printf "\r  [ \033[0;33m?\033[0m ] $1 "
}

success () {
  printf "\r\033[2K  [ \033[00;32mOK\033[0m ] $1\n"
}

fail () {
  printf "\r\033[2K  [\033[0;31mFAIL\033[0m] $1\n"
  echo ''
  exit
}

link_file () {
  local src=$1 dst=$2

  local overwrite= backup= skip=
  local action=

  if [ -f "$dst" -o -d "$dst" -o -L "$dst" ]
  then

    if [ "$overwrite_all" == "false" ] && [ "$backup_all" == "false" ] && [ "$skip_all" == "false" ]
    then

      local currentSrc="$(readlink $dst)"

      if [ "$currentSrc" == "$src" ]
      then

        skip=true;

      else

        user "File already exists: $dst ($(basename "$src")), what do you want to do?\n\
        [s]kip, [S]kip all, [o]verwrite, [O]verwrite all, [b]ackup, [B]ackup all?"
        read -n 1 action

        case "$action" in
          o )
            overwrite=true;;
          O )
            overwrite_all=true;;
          b )
            backup=true;;
          B )
            backup_all=true;;
          s )
            skip=true;;
          S )
            skip_all=true;;
          * )
            ;;
        esac

      fi

    fi

    overwrite=${overwrite:-$overwrite_all}
    backup=${backup:-$backup_all}
    skip=${skip:-$skip_all}

    if [ "$overwrite" == "true" ]
    then
      rm -rf "$dst"
      success "removed $dst"
      # echo "removed $dst"
    fi

    if [ "$backup" == "true" ]
    then
      mv "$dst" "${dst}.backup"
      success "moved $dst to ${dst}.backup"
      # echo "moved $dst to ${dst}.backup"
    fi

    if [ "$skip" == "true" ]
    then
      success "skipped $src"
      # echo "skipped $src"
    fi
  fi

  if [ "$skip" != "true" ]  # "false" or empty
  then
    ln -s "$1" "$2"
    success "linked $1 to $2"
    # echo "linked $1 to $2"
  fi
}

install_dotfiles () {
  info 'installing dotfiles\n'

  local overwrite_all=false backup_all=false skip_all=false

  for src in $(find "$DOTFILES_ROOT/" -maxdepth 2 -name '*.symlink')
  do
    # echo "Processing file: $src"

    # repace a substring in a string
    # Example:
    # var="/home/everbot/.vimrc"
    # echo ${var/everbot/ttt}
    # /home/ttt/.vimrc
    tmp=${src/$DOTFILES_ROOT\//} # replace the current root path by empty string

    # echo "tmp=$tmp" # debug only

    # if the current dotfile belong to the direct child of ~ directory
    if [ "$(dirname $tmp)" == "." ]
    then
        dst="$HOME/$(basename "${src%.*}")"
    else # now, the dotfile belong to some further sub-directory under ~
        tmp=${tmp%/*} # remove the basename of the file
        dst="$HOME/$tmp/$(basename "${src%.*}")"
    fi

    # echo "dst = $dst" # debug only

    # dst="$HOME/.$(basename "${src%.*}")" # original, which is kind of useless

    link_file "$src" "$dst"
  done
}

install_dotfiles

