By default, `.gitignore` file doesn't get symlinked because it is on the default
ignore list. To workaround, we need to add a `.stow-local-ignore` file to the
directory where the `.gitignore` is.

