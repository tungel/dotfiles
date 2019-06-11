;; vim: foldmethod=marker
;; Some packages need to install:
;; For FlySpell
;;   sudo pacman -S aspell aspell-en
;; For Ruby
;;   gem install pry pry-doc ruby_parser method_source

;; -*- mode: emacs-lisp -*-
;; This file is loaded by Spacemacs at startup.
;; It must be stored in your home directory.

(defun dotspacemacs/layers ()
  "Configuration Layers declaration.
You should not put any user code in this function besides modifying the variable
values."
  (setq-default
   ;; Base distribution to use. This is a layer contained in the directory
   ;; `+distribution'. For now available distributions are `spacemacs-base'
   ;; or `spacemacs'. (default 'spacemacs)
   dotspacemacs-distribution 'spacemacs
   ;; List of additional paths where to look for configuration layers.
   ;; Paths must have a trailing slash (i.e. `~/.mycontribs/')
   dotspacemacs-configuration-layer-path '()
   ;; List of configuration layers to load. If it is the symbol `all' instead
   ;; of a list then all discovered layers will be installed.
   dotspacemacs-configuration-layers
   '(
     ;; ----------------------------------------------------------------
     ;; Example of useful layers you may want to use right away.
     ;; Uncomment some layer names and press <SPC f e R> (Vim style) or
     ;; <M-m f e R> (Emacs style) to install them.
     ;; ----------------------------------------------------------------
     (auto-completion :variables
                     auto-completion-return-key-behavior 'complete
                     auto-completion-tab-key-behavior 'cycle
                     auto-completion-enable-help-tooltip t
                     auto-completion-enable-sort-by-usage t
                     auto-completion-enable-snippets-in-popup t
                     auto-completion-complete-with-key-sequence nil
                     auto-completion-private-snippets-directory nil)
     better-defaults
     emacs-lisp
     git
     markdown
     ; shell
     (shell :variables
            ; seem to cause problem starting shell?
            shell-default-position 'bottom
            shell-default-height 30
            ; shell-default-shell 'eshell

            ; shell-default-term-shell "/bin/bash"
            ; shell-enable-smart-eshell t
            shell-protect-eshell-prompt t
            )
     ; highlight-indentation
     (clojure :variables
              clojure-enable-fancify-symbols t)

     ; included haml as well
     html

     (ruby :variables ruby-enable-enh-ruby-mode t)
     ruby-on-rails
     org
     spell-checking

     ;; use status bar at the bottom for syntax checking report so that we can
     ;; use it in terminal emacs as well
     (syntax-checking :variables
                      syntax-checking-enable-tooltips nil)
     version-control
     )
   ;; List of additional packages that will be installed without being
   ;; wrapped in a layer. If you need some configuration for these
   ;; packages then consider to create a layer, you can also put the
   ;; configuration in `dotspacemacs/config'.
   dotspacemacs-additional-packages '()
   ;; A list of packages and/or extensions that will not be install and loaded.
   dotspacemacs-excluded-packages
   '(
     ; company
     )
   ;; If non-nil spacemacs will delete any orphan packages, i.e. packages that
   ;; are declared in a layer which is not a member of
   ;; the list `dotspacemacs-configuration-layers'. (default t)
   dotspacemacs-delete-orphan-packages t))

(defun dotspacemacs/init ()
  "Initialization function.
This function is called at the very startup of Spacemacs initialization
before layers configuration.
You should not put any user code in there besides modifying the variable
values."
  ;; This setq-default sexp is an exhaustive list of all the supported
  ;; spacemacs settings.
  (setq-default
   ;; One of `vim', `emacs' or `hybrid'. Evil is always enabled but if the
   ;; variable is `emacs' then the `holy-mode' is enabled at startup. `hybrid'
   ;; uses emacs key bindings for vim's insert mode, but otherwise leaves evil
   ;; unchanged. (default 'vim)
   dotspacemacs-editing-style 'vim
   ;; If non nil output loading progress in `*Messages*' buffer. (default nil)
   dotspacemacs-verbose-loading nil
   ;; Specify the startup banner. Default value is `official', it displays
   ;; the official spacemacs logo. An integer value is the index of text
   ;; banner, `random' chooses a random text banner in `core/banners'
   ;; directory. A string value must be a path to an image format supported
   ;; by your Emacs build.
   ;; If the value is nil then no banner is displayed. (default 'official)
   dotspacemacs-startup-banner 'official
   ;; List of items to show in the startup buffer. If nil it is disabled.
   ;; Possible values are: `recents' `bookmarks' `projects'.
   ;; (default '(recents projects))
   dotspacemacs-startup-lists '(recents projects)
   ;; List of themes, the first of the list is loaded when spacemacs starts.
   ;; Press <SPC> T n to cycle to the next theme in the list (works great
   ;; with 2 themes variants, one dark and one light)
   dotspacemacs-themes '(spacemacs-dark
                         spacemacs-light
                         material
                         spacegray
                         wilson
                         sanityinc-solarized-dark
                         solarized-light
                         solarized-dark
                         afternoon
                         alect-dark-alt
                         alect-light
                         molokai
                         ample
                         gruvbox
                         leuven
                         monokai
                         zenburn)
   ;; If non nil the cursor color matches the state color.
   dotspacemacs-colorize-cursor-according-to-state t
   ;; Default font. `powerline-scale' allows to quickly tweak the mode-line
   ;; size to make separators look not too crappy.
   ; dotspacemacs-default-font '("Consolas"
   ; dotspacemacs-default-font '("Source Code Pro for Powerline"
   ; dotspacemacs-default-font '("Ubuntu Mono derivative Powerline"
   dotspacemacs-default-font '("Dejavu Sans Mono for Powerline"
                               :size 24
                               :weight normal
                               :width normal
                               :powerline-scale 1.1)
   ;; The leader key
   dotspacemacs-leader-key "SPC"
   ;; The leader key accessible in `emacs state' and `insert state'
   ;; (default "M-m")
   dotspacemacs-emacs-leader-key "M-m"
   ;; Major mode leader key is a shortcut key which is the equivalent of
   ;; pressing `<leader> m`. Set it to `nil` to disable it. (default ",")
   ;; Tung: last time I set it to "nil" and I can't press `n` to do
   ;; `evil-search-next` because pressing `n` always brings up an annoying
   ;; `which-key` dialog
   dotspacemacs-major-mode-leader-key nil
   ;; Major mode leader key accessible in `emacs state' and `insert state'.
   ;; (default "C-M-m)
   dotspacemacs-major-mode-emacs-leader-key "C-M-m"
   ;; The command key used for Evil commands (ex-commands) and
   ;; Emacs commands (M-x).
   ;; By default the command key is `:' so ex-commands are executed like in Vim
   ;; with `:' and Emacs commands are executed with `<leader> :'.
   dotspacemacs-command-key ":"
   ;; If non nil `Y' is remapped to `y$'. (default t)
   dotspacemacs-remap-Y-to-y$ t
   ;; Location where to auto-save files. Possible values are `original' to
   ;; auto-save the file in-place, `cache' to auto-save the file to another
   ;; file stored in the cache directory and `nil' to disable auto-saving.
   ;; (default 'cache)
   dotspacemacs-auto-save-file-location 'cache
   ;; If non nil then `ido' replaces `helm' for some commands. For now only
   ;; `find-files' (SPC f f), `find-spacemacs-file' (SPC f e s), and
   ;; `find-contrib-file' (SPC f e c) are replaced. (default nil)
   dotspacemacs-use-ido nil
   ;; If non nil, `helm' will try to miminimize the space it uses. (default nil)
   dotspacemacs-helm-resize nil
   ;; if non nil, the helm header is hidden when there is only one source.
   ;; (default nil)
   dotspacemacs-helm-no-header nil
   ;; define the position to display `helm', options are `bottom', `top',
   ;; `left', or `right'. (default 'bottom)
   dotspacemacs-helm-position 'bottom
   ;; If non nil the paste micro-state is enabled. When enabled pressing `p`
   ;; several times cycle between the kill ring content. (default nil)
   dotspacemacs-enable-paste-micro-state nil
   ;; Which-key delay in seconds. The which-key buffer is the popup listing
   ;; the commands bound to the current keystroke sequence. (default 0.4)
   dotspacemacs-which-key-delay 0.4
   ;; Which-key frame position. Possible values are `right', `bottom' and
   ;; `right-then-bottom'. right-then-bottom tries to display the frame to the
   ;; right; if there is insufficient space it displays it at the bottom.
   ;; (default 'bottom)
   dotspacemacs-which-key-position 'bottom
   ;; If non nil a progress bar is displayed when spacemacs is loading. This
   ;; may increase the boot time on some systems and emacs builds, set it to
   ;; nil to boost the loading time. (default t)
   dotspacemacs-loading-progress-bar t
   ;; If non nil the frame is fullscreen when Emacs starts up. (default nil)
   ;; (Emacs 24.4+ only)
   dotspacemacs-fullscreen-at-startup nil
   ;; If non nil `spacemacs/toggle-fullscreen' will not use native fullscreen.
   ;; Use to disable fullscreen animations in OSX. (default nil)
   dotspacemacs-fullscreen-use-non-native nil
   ;; If non nil the frame is maximized when Emacs starts up.
   ;; Takes effect only if `dotspacemacs-fullscreen-at-startup' is nil.
   ;; (default nil) (Emacs 24.4+ only)
   dotspacemacs-maximized-at-startup nil
   ;; A value from the range (0..100), in increasing opacity, which describes
   ;; the transparency level of a frame when it's active or selected.
   ;; Transparency can be toggled through `toggle-transparency'. (default 90)
   dotspacemacs-active-transparency 90
   ;; A value from the range (0..100), in increasing opacity, which describes
   ;; the transparency level of a frame when it's inactive or deselected.
   ;; Transparency can be toggled through `toggle-transparency'. (default 90)
   dotspacemacs-inactive-transparency 90
   ;; If non nil unicode symbols are displayed in the mode line. (default t)
   dotspacemacs-mode-line-unicode-symbols t
   ;; If non nil smooth scrolling (native-scrolling) is enabled. Smooth
   ;; scrolling overrides the default behavior of Emacs which recenters the
   ;; point when it reaches the top or bottom of the screen. (default t)
   dotspacemacs-smooth-scrolling t
   ;; If non-nil smartparens-strict-mode will be enabled in programming modes.
   ;; (default nil)
   dotspacemacs-smartparens-strict-mode nil
   ;; Select a scope to highlight delimiters. Possible values are `any',
   ;; `current', `all' or `nil'. Default is `all' (highlight any scope and
   ;; emphasis the current one). (default 'all)
   dotspacemacs-highlight-delimiters 'all
   ;; If non nil advises quit functions to keep server open when quitting.
   ;; (default nil)
   dotspacemacs-persistent-server nil
   ;; List of search tool executable names. Spacemacs uses the first installed
   ;; tool of the list. Supported tools are `ag', `pt', `ack' and `grep'.
   ;; (default '("ag" "pt" "ack" "grep"))
   dotspacemacs-search-tools '("ag" "pt" "ack" "grep")
   ;; The default package repository used if no explicit repository has been
   ;; specified with an installed package.
   ;; Not used for now. (default nil)
   dotspacemacs-default-package-repository nil
   ))

(defun dotspacemacs/user-init ()
  "Initialization function for user code.
It is called immediately after `dotspacemacs/init'.  You are free to put any
user code."
  ; (setq dotspacemacs-fullscreen-at-startup t)

  ;; ref: https://github.com/nashamri/spacemacs-theme
  (custom-set-variables '(spacemacs-theme-custom-colors
                          '(
                            (comment . "#7c6f64")
                            (green-bg-s . "#ff0000")
                            )))
  )

(defun dotspacemacs/user-config ()
  "Configuration function for user code.
 This function is called at the very end of Spacemacs initialization after
layers configuration. You are free to put any user code."
  ; (setq debug-on-error t) ; show more info upon error

  ;; enable wrapping long lines
  ;; ref: http://emacs.stackexchange.com/questions/3747/how-to-disable-line-wrapping-in-spacemacs
  (add-hook 'hack-local-variables-hook (lambda () (setq truncate-lines nil)))

  ;; Enable navigation by visual lines
  ;; ref: https://github.com/syl20bnr/spacemacs/blob/master/doc/HOWTOs.org
  ;; Make evil-mode up/down operate in screen lines instead of logical lines
  (define-key evil-motion-state-map "j" 'evil-next-visual-line)
  (define-key evil-motion-state-map "k" 'evil-previous-visual-line)
  ;; Also in visual mode
  (define-key evil-visual-state-map "j" 'evil-next-visual-line)
  (define-key evil-visual-state-map "k" 'evil-previous-visual-line)

  ; (global-linum-mode) ; Show line numbers by default
  (add-hook 'prog-mode-hook 'linum-mode) ; only show line number in programming
  (add-hook 'markdown-mode-hook 'linum-mode) ; show line number in markdown

  (global-set-key (kbd "<f6>") 'flyspell-buffer)

  ; show 80 column indicator
  (define-globalized-minor-mode global-fci-mode fci-mode (lambda () (fci-mode 1)))
  (global-fci-mode 1)

  ;; Set escape keybinding to "jk"
  ; (setq-default evil-escape-key-sequence "jk") ; will cause jk to escape in other situation too, so not good

  ; http://article.gmane.org/gmane.emacs.vim-emulation/980
  ; https://zuttobenkyou.wordpress.com/2011/02/15/some-thoughts-on-emacs-and-vim/
  (define-key evil-insert-state-map "j" #'cofi/maybe-exit)
  (evil-define-command cofi/maybe-exit ()
    :repeat change
    (interactive)
    (let ((modified (buffer-modified-p)))
        (insert "j")
        (let ((evt (read-event (format "Insert %c to exit insert state" ?k)
                nil 0.5)))
        (cond
            ((null evt) (message ""))
            ((and (integerp evt) (char-equal evt ?k))
            (delete-char -1)
            (set-buffer-modified-p modified)
            (push 'escape unread-command-events))
            (t (setq unread-command-events (append unread-command-events
                            (list evt))))))))

  ; below solution will make the j key stuck
  ;; (setq key-chord-two-keys-delay 0.5)
  ;; (define-key evil-insert-state-map "jk" 'evil-normal-state)

  ; don't use tab for indentation, it's evil
  (setq-default tab-always-indent 'complete)
  (setq indent-tabs-mode nil)
  (setq tab-width 2)
  (setq-default tab-width 2)
  (setq-default standard-indent 2)
  (setq highlight-indentation-offset 2) ; for highlight-indentation to draw correctly

  ; use small mode-line bar because the big one is broken
  (setq spacemacs-mode-line-minor-modesp nil)
  (setq powerline-default-separator 'arrow)
  (spacemacs/toggle-mode-line-minor-modes-off)

  (define-key global-map (kbd "C-=") 'text-scale-increase)
  (define-key global-map (kbd "C--") 'text-scale-decrease)
  (define-key global-map (kbd "C-h") 'delete-backward-char)

  ; (define-key global-map (kbd "C-[") 'keyboard-escape-quit)

  (define-key evil-normal-state-map "\M--" 'evil-window-decrease-width)
  (define-key evil-normal-state-map "\M-=" 'evil-window-increase-width)
  (define-key evil-normal-state-map ",b" 'helm-buffers-list)
  (define-key evil-normal-state-map (kbd "C-s") 'evil-write)
  (define-key evil-insert-state-map (kbd "C-s") 'evil-write)
  (define-key evil-normal-state-map ",o" 'imenu)
  (define-key evil-normal-state-map ",f" 'helm-projectile)
  (define-key evil-normal-state-map ",F" 'helm-find-files)
  (define-key evil-normal-state-map "\C-]" 'helm-etags-select)
  (define-key evil-normal-state-map ",ig" 'highlight-indentation-mode)
  (define-key evil-normal-state-map ",c" 'delete-window)
  (define-key evil-normal-state-map ",C" 'kill-this-buffer)
  (define-key evil-normal-state-map ",m" 'helm-recentf)
  (define-key evil-normal-state-map ",M" 'helm-projectile-recentf)
  (define-key evil-motion-state-map "n" 'evil-search-next) ; may not need to set this here

  ;; fix `o` and `O` leave trailing whitespaces on empty lines
  (defun evil-insert-newline-below ()
    (end-of-line)
    (newline-and-indent)
    )
  (defun evil-insert-newline-above ()
    (evil-previous-visual-line 1)
    (end-of-line)
    (newline-and-indent)
    )

  ; search like vim-easy motion, but with just 1 char at the start of a word
  (define-key evil-normal-state-map "s" 'evil-avy-goto-word-or-subword-1)
  ;; (define-key evil-normal-state-map "s" 'evil-avy-goto-char-2)

  ; don't delete backward char in normal mode
  (define-key evil-normal-state-map (kbd "C-h") 'evil-backward-char)

  ; (indent-guide-global-mode)
  (setq indent-guide-recursive 1) ; create error max deep recursion
  ; (setq indent-guide-char "|")
  ; (setq indent-guide-delay 0.1)

  (global-company-mode) ; disable company mode so we can auto-complete engine
  (defun my-company()
    ;; these 2 won't cycle
    ; (define-key company-active-map "\C-n" 'company-select-next)
    ; (define-key company-active-map "\C-p" 'company-select-previous)

    ;; these 2 get cycled around
    (define-key company-active-map "\C-n" 'company-complete-common-or-cycle)
    (define-key company-active-map "\C-p" 'spacemacs//company-complete-common-or-cycle-backward)
    (define-key company-active-map "\C-h" 'delete-backward-char)
    )
  (add-hook 'company-mode-hook 'my-company)

  ;; for auto-complete
  ; (global-auto-complete-mode)
  ; (setq ac-delay 0.01)
  ;; keybinding to select next/previous candidate
  ; (defun my-ac()
  ;   (define-key ac-complete-mode-map "\C-n" 'ac-next)
  ;   (define-key ac-complete-mode-map "\C-p" 'ac-previous)
  ;   )
  ; (add-hook 'auto-complete-mode-hook 'my-ac)

  (defun my-highlight-indentation()
    ; (set-face-background 'highlight-indentation-face "#2f2f2f")

    ; same as comment background color of spacemacs dark
    (if (display-graphic-p)
      (set-face-background 'highlight-indentation-face "#292e34") ; GUI
      ; (set-face-background 'highlight-indentation-face "#453e40") ; Terminal
      ;; http://www.w3schools.com/tags/ref_colorpicker.asp
      ;; look at the lighter/darker color
      (set-face-background 'highlight-indentation-face "#363032") ; Terminal
      )
    )
  (add-hook 'highlight-indentation-mode-hook 'my-highlight-indentation)

  ; auto show block indentation guide, quite slow with large file
  ; (add-hook 'prog-mode-hook 'highlight-indentation-mode)

  ; not working
  (defun my-cider()
    (define-key cider-repl-mode-map "\C-n" 'cider-repl-forward-input)
    (define-key cider-repl-mode-map "\C-p" 'cider-repl-backward-input)
    )
  (add-hook 'cider-repl-mode-hook 'my-cider)


  (ansi-color-for-comint-mode-on)
  ; (add-hook 'shell-mode-hook (lambda ()
  ;       (ansi-color-for-comint-mode-on)))
  ; http://superuser.com/questions/31533/how-do-i-fix-my-prompt-in-emacs-shell-mode
  ; (autoload 'ansi-color-for-comint-mode-on "ansi-color" nil t)
  ; (add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on)

  ; enable C-h to delete backspace char
  (spacemacs|use-package-add-hook helm
    :pre-init
    ;; Code
    :post-init
    ;; Code
    :pre-config
    ;; Code
    :post-config
      (setq help-char nil) ; whenever you rebind C-h you should also change the value of help-char

      ; use the longest buffer name available (default is about 20 which is very short
      (setq helm-buffer-max-length 60)

      ; (define-key helm-find-files-map (kbd "C-h") nil) ; only for find-files?
      (define-key helm-map (kbd "C-h") nil) ; make it helm global
      (define-key helm-map (kbd "C-w") 'backward-kill-word)

      ; default is C-c C-o
      (define-key helm-map (kbd "C-o") 'helm-ff-run-switch-other-window)

      ; this doesn't seem to affect the helm-find-files though!
      (define-key helm-map (kbd "C-l") 'helm-kill-selection-and-quit)
  )

  ;; (defun my-shell()
  ;;   (setq shell-default-position 'right)
  ;;   (setq shell-default-height 30)
  ;;   (setq shell-enable-smart-eshell t)
  ;;   )
  ;; (add-hook 'shell-mode-hook 'my-shell)

  (defun my-helm()
    ; default is C-c C-o
    (define-key helm-buffer-map (kbd "C-o") 'helm-buffer-switch-other-window)
    )
  (add-hook 'helm-mode-hook 'my-helm)

  (defun my-helm-ff()
    ; default is C-c C-k
    (define-key helm-find-files-map (kbd "C-l") 'helm-kill-selection-and-quit)
    )
  (add-hook 'helm-find-files-after-init-hook 'my-helm-ff)

  (defun my-enh-ruby()
    (define-key enh-ruby-mode-map (kbd "<f9>") 'ruby-send-region)
    (define-key evil-normal-state-map ",tn" 'ruby-test-run-at-point)
    ; (define-key ruby-mode-map (kbd "M-b") 'ruby-send-region)
    )
  ; (add-hook 'ruby-mode-hook 'my-enh-ruby)
  (add-hook 'enh-ruby-mode-hook 'my-enh-ruby)
  (setq enh-ruby-deep-indent-paren nil)
  (setq ruby-deep-indent-paren nil)
  (setq ruby-indent-level 2)
  (setq enh-ruby-indent-level 2)

  ;; disable auto syntax checking for Ruby
  (remove-hook 'enh-ruby-mode-hook 'flycheck-mode)

  ; for debug using pry
  ; http://emacs.stackexchange.com/questions/3537/how-do-you-run-pry-from-emacs
  ; when you hit breakpoint, hit C-x C-q to enable inf-ruby
  (add-hook 'enh-ruby-mode-hook 'inf-ruby-switch-setup)


  ;; which-function-mode stuff
  ;; http://www.emacswiki.org/emacs/WhichFuncMode
  (which-function-mode)
  (eval-after-load "which-func"
      '(setq which-func-modes '(enh-ruby-mode ruby-mode java-mode c++-mode org-mode)))

  ;; display the method the current line belong to, at the top
  ; http://emacs.stackexchange.com/questions/2222/show-current-function-in-header-line
  ; (setq-default header-line-format
  ;             '((which-function-mode ("" which-func-format " "))))
  ; (setq mode-line-misc-info
  ;           ;; We remove Which Function Mode from the mode line, because it's mostly
  ;           ;; invisible here anyway.
  ;           (assq-delete-all 'which-function-mode mode-line-misc-info))

  ;; don't allow dired to create new buffer
  (add-hook 'dired-mode-hook
    (lambda ()
        ; we still can use `o` to open the current item in new buffer

        (define-key dired-mode-map (kbd "RET") 'dired-find-alternate-file)
        (define-key dired-mode-map (kbd "^")
            (lambda () (interactive) (find-alternate-file "..")))
        (define-key dired-mode-map (kbd "u")
            (lambda () (interactive) (find-alternate-file "..")))
        ; was dired-up-directory
    ))


  ;;; messy stuff for modeline to show which function {{{
  (setq which-func-format
    '((:propertize which-func-current local-map
        (keymap
            (mode-line keymap
                (mouse-3 . end-of-defun)
                (mouse-2 .
                        #[nil "e\300=\203	 \301 \207~\207"
                                [1 narrow-to-defun]
                                2 nil nil])
                (mouse-1 . beginning-of-defun)))
        face which-func mouse-face mode-line-highlight help-echo "mouse-1: go to beginning\nmouse-2: toggle rest visibility\nmouse-3: go to end")
        ))
  ; (spacemacs|define-mode-line-segment relative-dir
  (spaceline-define-segment relative-dir
    (if (and buffer-file-name (projectile-project-p))
        (file-name-directory
         (file-relative-name buffer-file-name (projectile-project-root)))
      (if buffer-file-name
          (concat
           "/"
           (file-name-nondirectory
            (directory-file-name
             (file-name-directory buffer-file-name)))
           "/")
        )
      )
    )
  ; (spacemacs|define-mode-line-segment my-which-func
  (spaceline-define-segment my-which-func
      ; '((which-function-mode ("" which-func-format ""))) ; work
      ; '(("" which-func-format "")) ; work
      ; (upcase "tung") ; work
      which-func-format ; work
      ; (upcase which-func-format)

      ; (let ((wf '(("" which-func-format ""))))
      ;   ; (upcase (symbol-name wf))) ; convert symbol to string
      ;   which-func-format)
      ;   ; wf)

      ; '((which-function-mode ((replace-regexp-in-string "[][]" "" which-func-format))))
    )
  (setq spaceline-left
        '(
          ;; don't need to show window-number
          ; ((workspace-number window-number)
          ;  :fallback state-tag
          ;  :separator "|"
          ;  :face state-face)

          anzu

          ; (buffer-modified buffer-size relative-dir buffer-id remote-host)
          ;; don't need to show `buffer-size` and `relative-dir`
          buffer-modified
          (buffer-id remote-host)

          major-mode
          my-which-func
          ((flycheck-errors flycheck-warnings flycheck-infos)
           :when active)
          ((minor-modes process)
           :when active)
          (erc-track :when active)
          (version-control :when active)
          (org-pomodoro :when active)
          (org-clock :when active)
          nyan-cat)
        )
  ;; end which funct mode line }}}


  ;; white space {{{
  ; don't use show-trailing-whitespace because it's not compatible with
  ; fill-column-indicator (fci) https://github.com/alpaker/Fill-Column-Indicator
  (setq spacemacs-show-trailing-whitespace nil)

  ;; use white-space mode instead
  (setq whitespace-style '(face trailing))
  (add-hook 'prog-mode-hook 'whitespace-mode)

  ;; don't need to set this since we have `underline` in the `custom-set-faces` below
  ;; (setq whitespace-trailing 'underline)

  ;; backup `custom-set-faces`
  ;; '(whitespace-trailing ((t (:background nil :foreground "#dc752f" :underline t)))))
  ;; '(whitespace-trailing ((t (:background "sienna" :foreground "#dc752f")))))
  ;; end white space }}}

  ;; Enable copy and paste with system cliboard when using Emacs in terminal
  ;; Ref: https://hugoheden.wordpress.com/2009/03/08/copypaste-with-emacs-in-terminal/
  ;; If emacs is run in a terminal, the clipboard- functions have no
  ;; effect. Instead, we use of xsel, see
  ;; http://www.vergenet.net/~conrad/software/xsel/ -- "a command-line
  ;; program for getting and setting the contents of the X selection"
  (unless window-system
    (when (getenv "DISPLAY")
      ;; Callback for when user cuts
      (defun xsel-cut-function (text &optional push)
        ;; Insert text to temp-buffer, and "send" content to xsel stdin
        (with-temp-buffer
          (insert text)
          ;; I prefer using the "clipboard" selection (the one the
          ;; typically is used by c-c/c-v) before the primary selection
          ;; (that uses mouse-select/middle-button-click)
          (call-process-region (point-min) (point-max) "xsel" nil 0 nil "--clipboard" "--input")))
      ;; Call back for when user pastes
      (defun xsel-paste-function()
        ;; Find out what is current selection by xsel. If it is different
        ;; from the top of the kill-ring (car kill-ring), then return
        ;; it. Else, nil is returned, so whatever is in the top of the
        ;; kill-ring will be used.
        (let ((xsel-output (shell-command-to-string "xsel --clipboard --output")))
          (unless (string= (car kill-ring) xsel-output)
            xsel-output )))
      ;; Attach callbacks to hooks
      (setq interprogram-cut-function 'xsel-cut-function)
      (setq interprogram-paste-function 'xsel-paste-function)
      ;; Idea from
      ;; http://shreevatsa.wordpress.com/2006/10/22/emacs-copypaste-and-x/
      ;; http://www.mail-archive.com/help-gnu-emacs@gnu.org/msg03577.html
       ))
)

;; example how to set whitespace color:
; (setq whitespace-style '(face tabs))
; (setq tab-face (make-face 'tab-face))
; (set-face-background 'tab-face "red")
; (setq whitespace-tab 'tab-face)
; (whitespace-mode)

;; Do not write anything past this comment. This is where Emacs will
;; auto-generate custom variable definitions.
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(spacemacs-theme-custom-colors (quote ((comment . "#7c6f64") (green-bg-s . "#ff0000")))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(company-tooltip-common ((t (:inherit company-tooltip :weight bold :underline nil))))
 '(company-tooltip-common-selection ((t (:inherit company-tooltip-selection :weight bold :underline nil))))
 '(whitespace-trailing ((t (:background nil :foreground "#dc752f" :underline t)))))
 ; '(whitespace-trailing ((t (:background "sienna" :foreground "#dc752f")))))
