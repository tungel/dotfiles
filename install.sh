#!/bin/bash

usage='Usage: ./install.sh [-n] [-o] app1 [app2 app3 ..]
  -n   dry-run; no filesystem changes
  -o   overwrite conflict files'

DRY_RUN=0
OVERWRITE=0

TARGET_DIR=~
# create .config/ranger because we only partially symlink ranger
# for more info, read `common/.config/ranger/note.md`
mkdir -p $TARGET_DIR/.config/ranger

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
NC='\033[0m' # No Color

while getopts 'no' opts; do
  case $opts in
    n ) DRY_RUN=1;;
    o ) OVERWRITE=1;;
    * ) echo "$usage"
        exit 1;;
  esac
done
shift $((OPTIND-1))

function backup_existing {
  # loop through all the lines in $1
  while IFS= read -r filename; do
    local concerned_file_path="${TARGET_DIR}/${filename}"
    printf "${YELLOW}Checking conflict file${NC} ${filename}\n"
    if [[ -f "${concerned_file_path}" || -L "${concerned_file_path}" ]]; then
      if [[ ${DRY_RUN} -eq 0 ]]; then
        if [[ ${OVERWRITE} -eq 0 ]]; then
          printf "  ${GREEN}Backing up${NC} ${concerned_file_path}\n"
          mv "${concerned_file_path}" "${concerned_file_path}.backup"
        else
          printf "  ${YELLOW}Removing conflict file${NC} ${concerned_file_path}\n"
          rm "${concerned_file_path}"
        fi
      fi
    fi
  done <<< "$1"
}

DOTFILES="common"

KERNEL=$(uname -s)
if [[ "${KERNEL}" == "Darwin" ]]; then
  DOTFILES="common macos"
elif [[ "${KERNEL}" == "Linux" && -f "/etc/arch-release" ]]; then
  DOTFILES="common archlinux"
fi

# Searching for conflict files from error msg like:
# "* existing target is neither a link nor a directory: .config/youtube dl/config"

# Note: on macOS, sed doesn't understand `\t` as TAB, so we need to use {TAB} in
# the regex. See: https://stackoverflow.com/questions/2610115/why-is-sed-not-recognizing-t-as-a-tab
# The `sed` part is to trim leading and trailing spaces
# For `awk`: we use `:` as the separator, and `print $NF` prints only the last column
TAB=$'\t'
CONFLICTS=$(stow -nv $DOTFILES --target="${TARGET_DIR}" 2>&1 | awk -F':' '/\* existing target is/ {print $NF}' | sed "s/^[ ${TAB}]*//;s/[ ${TAB}]*$//")
backup_existing "$CONFLICTS"

# Note: don't use "${DOTFILES}" because stow will treat something like
# "common linux" as one word. Just write $DOTFILES instead.
if [[ $DRY_RUN -eq 1 ]]; then
  stow -v $DOTFILES --target="${TARGET_DIR}" -n
else
  stow -v $DOTFILES --target="${TARGET_DIR}"
fi

# run custom commands after installing dotfiles
~/.config/ranger/configure-ranger.sh
if [[ "${KERNEL}" == "Darwin" ]]; then
  # Specify the preferences directory
  defaults write com.googlecode.iterm2.plist PrefsCustomFolder -string "~/macOS-configs/iterm2"

  # Tell iTerm2 to use the custom preferences
  defaults write com.googlecode.iterm2.plist LoadPrefsFromCustomFolder -bool true

  # setup login hook for key mapping. Note for ansible: this will ask for sudo password
  # sudo defaults write com.apple.loginwindow LoginHook ~/macOS-configs/login-script.sh
  ~/macOS-configs/login-script.sh
  mkdir -p ~/Library/LaunchAgents
  cp ~/macOS-configs/com.tungle.KeysMapping.plist ~/Library/LaunchAgents/
  # replace the placeholder with real user's home dir
  # https://stackoverflow.com/questions/4247068/sed-command-with-i-option-failing-on-mac-but-works-on-linux
  sed -i '' s:USER_HOME_DIR_PLACEHOLDER:$HOME: ~/Library/LaunchAgents/com.tungle.KeysMapping.plist
  launchctl load com.tungle.KeysMapping.plist
fi

