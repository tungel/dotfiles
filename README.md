# Introduction
My personal dotfiles collection.

How it looks like: https://www.youtube.com/watch?v=sKDQ4rXFCF4

# Packages:
Here is the list of relevant packages/programs that I use in Arch Linux. You
don't need to install everything below, just choose what you want and then
select which dotfile to be symlinked in the `config` file.

- `bspwm` for window manager
- `sxhkd`
- `dzen2`
- `trayer`
- `xtitle-git` (yaourt)
- `dmenu-xft` (yaourt)
- `xclip`
- `zsh`
- `tmux`
- `rxvt-unicode`
- `neovim` (yaourt)

## Install required packages for Linux Mint

I use Linux Mint occasionally, so here is the minimum list of packages that I
want to install in order to make use of my dotfiles repo:

- `sudo apt-get install rxvt-unicode-256color`
- `sudo apt-get install zsh`
- `sudo apt-get install tmux`
- `sudo apt-get Install xclip`

# Manage subtrees:

- Change dir to the root of this repo, then:
- Add `zsh-git-prompt` subtree:

```
git subtree add --prefix .zplugins.symlink/zsh-git-prompt https://github.com/olivierverdier/zsh-git-prompt.git master --squash
```

- Get update from the original repo:

```
git subtree pull --prefix .zplugins.symlink/zsh-git-prompt https://github.com/olivierverdier/zsh-git-prompt.git master --squash
```

# Usage

- Install the packages/programs that you want as mentioned above
- Clone this repo: `git clone git@github.com:everbot/dotfiles.git`
- Clone the `.vim` repo: `git clone git@github.com:everbot/.vim.git`
  or clone with HTTPS: `git clone https://github.com/everbot/.vim.git`
- Change directory to where you cloned the dotfiles: `cd dotfiles`
- Edit `config` file to specify which dotfiles are to be symlinked
- Then, run: `bash install.sh`
- Symlink the .vim directory: `ln -s /path/to/downloaded/.vim ~/.vim`
- Done!

