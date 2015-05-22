# dotfiles
My dotfiles repo

I love tinkering with configuration files. So here is my dotfiles repo.

## Arch Linux:
- I should know very well which packages are required to install.

## Install required packages for Linux Mint:

- `sudo apt-get install rxvt-unicode-256color`
- `sudo apt-get install zsh`
- `sudo apt-get install tmux`
- `sudo apt-get Install xclip`

## Manage subtrees:

- Change dir to the root of this repo, then:
- Add `zsh-git-prompt` subtree:

`git subtree add --prefix .zplugins.symlink/zsh-git-prompt https://github.com/olivierverdier/zsh-git-prompt.git master --squash`

- Get update from the original repo:

`git subtree pull --prefix .zplugins.symlink/zsh-git-prompt https://github.com/olivierverdier/zsh-git-prompt.git master --squash`

## Usage

- Clone this repo: `git clone git@github.com:everbot/dotfiles.git`
- Clone the .vim repo: `git clone git@github.com:everbot/.vim.git`
- Change directory to where you cloned the dotfiles: `cd dotfiles`
- Edit `config` file to specify which dotfiles are to be symlinked
- Then, run: `bash install.sh`
- Symlink the .vim directory: `ln -s /path/to/downloaded/.vim ~/.vim`
- Done!

