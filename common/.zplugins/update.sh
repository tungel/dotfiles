#!/bin/bash

# Update all plugins

curl -O https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/plugins/tmux/tmux.plugin.zsh
curl -O https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/plugins/z/z.sh
curl -O https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/plugins/sudo/sudo.plugin.zsh
curl -O https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/plugins/dirhistory/dirhistory.plugin.zsh
curl -O https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/plugins/archlinux/archlinux.plugin.zsh

plugins=(zsh-syntax-highlighting zsh-history-substring-search zsh-completions zsh-autosuggestions)

function update_plugin() {
  if [[ "$#" -ne 2 ]]; then
    echo "First param is something like https://github.com/zsh-users"
    echo "Second param is the repo name (such as: zsh-syntax-highlighting)"
    exit 1
  fi

  local url="$1/$2"

  rm -rf "$2"
  echo "Cloning ${url}.git"
  git clone "${url}.git"
  rm -rf "$2/.git"
}

for plugin in "${plugins[@]}"; do
  update_plugin "https://github.com/zsh-users" "${plugin}"
done

update_plugin "https://github.com/olivierverdier" "zsh-git-prompt"

