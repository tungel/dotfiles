# Arch Linux dependency packages

- `bspwm` for window manager
- `sxhkd`
- `polybar-git` (via `yay`) for status bar
- `dmenu`
- `xclip`
- `zsh`
- `tmux`
- `alacritty` terminal emulator
- `neovim`
- `LunarVim` https://github.com/LunarVim/LunarVim
- `starship` cross-shell prompt

## Fonts

- ttf-dejavu
- ttf-hack
- ttf-roboto
- ttf-liberation
- nerd-fonts-fantasque-sans-mono (yay)
- nerd-fonts-fira-code (yay)
- nerd-fonts-jetbrains-mono (yay)

# Note on stow

By default, `.gitignore` file doesn't get symlinked because it is on the default
ignore list. To workaround, we need to add a `.stow-local-ignore` file to the
directory that contains the `.gitignore` file.

