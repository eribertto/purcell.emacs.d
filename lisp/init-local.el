;;; init-local.el --- Configure default init file -*- lexical-binding: t -*-
;;; Commentary:
;;; Code:

;;; Emfy 0.3.0 <https://github.com/susam/emfy>
;;; edited by user me April 13, 2024

(require 'desktop)
(desktop-save-mode 1)
(defun my-desktop-save ()
  "Don't prompt desktop-save-in-desktop-dir."
  (interactive)
  (if (eq (desktop-owner) (emacs-pid))
      (desktop-save desktop-dirname))
  )
(add-hook 'auto-save-hook 'my-desktop-save)


;; Customize user interface.
(when (display-graphic-p)
  (tool-bar-mode 1)
  (scroll-bar-mode 1))
(setq inhibit-startup-screen t)
(column-number-mode)


;; Show stray whitespace.
(setq-default show-trailing-whitespace t)
(setq-default indicate-empty-lines t)
(setq-default indicate-buffer-boundaries 'left)

;; Add a newline automatically at the end of a file while saving.
(setq-default require-final-newline t)

;; Consider a period followed by a single space to be end of sentence.
(setq sentence-end-double-space nil)

;; Use spaces, not tabs, for indentation.
(setq-default indent-tabs-mode nil)

;; Display the distance between two tab stops as 4 characters wide.
(setq-default tab-width 4)

;; Indentation setting for various languages.
;; (setq c-basic-offset 4)
;; (setq js-indent-level 2)
;; (setq css-indent-offset 2)

;; Highlight matching pairs of parentheses.
(setq show-paren-delay 0)
(show-paren-mode)

;; Write auto-saves and backups to separate directory.
(make-directory "~/.tmp/emacs/auto-save/" t)
(setq auto-save-file-name-transforms '((".*" "~/.tmp/emacs/auto-save/" t)))
(setq backup-directory-alist '(("." . "~/.tmp/emacs/backup/")))

;; Do not move the current file while creating backup.
(setq backup-by-copying t)

;; Disable lockfiles.
(setq create-lockfiles nil)

;; ;; Workaround for https://debbugs.gnu.org/34341 in GNU Emacs <= 26.3.
;; (when (and (version< emacs-version "26.3") (>= libgnutls-version 30603))
;;   (setq gnutls-algorithm-priority "NORMAL:-VERS-TLS1.3"))

;; Write customizations to a separate file instead of this file.
(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(load custom-file t)

;; Enable installation of packages from MELPA.
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)
(unless package-archive-contents
  (package-refresh-contents))

;; Install packages.
(dolist (package '(markdown-mode deadgrep nix-mode w3m ef-themes dired-sidebar denote paredit rainbow-delimiters xah-fly-keys popper all-the-icons all-the-icons-dired all-the-icons-completion marginalia sly  eat eglot savehist racket-mode geiser-racket quack scribble-mode vertico orderless corfu magit howm org-superstar))
  (unless (package-installed-p package)
    (package-install package)))

;; sly-asdf sly-quicklisp ;; exclude this from the dolist, for now

;; racket-mode geiser-racket quack scribble-mode ; <-- these guys are for racket programming language

;; Enable Paredit.
(add-hook 'emacs-lisp-mode-hook 'enable-paredit-mode)
(add-hook 'eval-expression-minibuffer-setup-hook 'enable-paredit-mode)
(add-hook 'ielm-mode-hook 'enable-paredit-mode)
(add-hook 'lisp-interaction-mode-hook 'enable-paredit-mode)
(add-hook 'lisp-mode-hook 'enable-paredit-mode)

;; Enable Rainbow Delimiters.
(add-hook 'emacs-lisp-mode-hook 'rainbow-delimiters-mode)
(add-hook 'ielm-mode-hook 'rainbow-delimiters-mode)
(add-hook 'lisp-interaction-mode-hook 'rainbow-delimiters-mode)
(add-hook 'lisp-mode-hook 'rainbow-delimiters-mode)

;; Customize Rainbow Delimiters.
;; (require 'rainbow-delimiters)
(use-package rainbow-delimiters)
(set-face-foreground 'rainbow-delimiters-depth-1-face "#c66")  ; red
(set-face-foreground 'rainbow-delimiters-depth-2-face "#6c6")  ; green
(set-face-foreground 'rainbow-delimiters-depth-3-face "#69f")  ; blue
(set-face-foreground 'rainbow-delimiters-depth-4-face "#cc6")  ; yellow
(set-face-foreground 'rainbow-delimiters-depth-5-face "#6cc")  ; cyan
(set-face-foreground 'rainbow-delimiters-depth-6-face "#c6c")  ; magenta
(set-face-foreground 'rainbow-delimiters-depth-7-face "#ccc")  ; light gray
(set-face-foreground 'rainbow-delimiters-depth-8-face "#999")  ; medium gray
(set-face-foreground 'rainbow-delimiters-depth-9-face "#666")  ; dark gray

;; Custom command.
(defun show-current-time ()
  "Show current time."
  (interactive)
  (message (current-time-string)))

;; Custom key sequences.
(global-set-key (kbd "C-c t") 'show-current-time)
(global-set-key (kbd "C-c d") 'delete-trailing-whitespace)

;; Start server.
(require 'server)
(unless (server-running-p)
  (server-start))

;; Some customizations

;; set utf8
(set-charset-priority 'unicode) ;; utf8 in every nook and cranny
(setq locale-coding-system 'utf-8
      coding-system-for-read 'utf-8
      coding-system-for-write 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(set-selection-coding-system 'utf-8)
(prefer-coding-system 'utf-8)
(setq default-process-coding-system '(utf-8-unix . utf-8-unix))

;; my details
(setq user-full-name "Eriberto Mendz")
(setq user-mail-address "erimendz@gmail.com")

(use-package xah-fly-keys
  :config
  (xah-fly-keys-set-layout "qwerty")
  (xah-fly-keys 1))

(global-set-key (kbd "<f5>") 'xah-fly-mode-toggle) ; this works

;; add a key to insert mode to activate command mode sort of jk escape in vim
;; note the term 'a key' meaning only one key char
;; use target key \ aka forward slash but
;; note to use this literal char (in insert mode) hit C-q first

;; this doesnt work in insert mode
;; (define-key xah-fly-insert-map (kbd "\\") 'xah-fly-command-mode-activate)
;; insert by doing C-q first then the character \  (in insert mode)

;; modeline colors and icons
;; EndeavourOS = " "
(setq xah-fly-command-mode-indicator " ")
(setq xah-fly-insert-mode-indicator "✏" )
(defun my-modeline-color-on ()
  "Make mode-line color blue."
  (set-face-background 'mode-line "blue"))
(defun my-modeline-color-off ()
  "Make mode-line color firebrick."
  (set-face-background 'mode-line "firebrick"))

(add-hook 'xah-fly-command-mode-activate-hook 'my-modeline-color-on)
(add-hook 'xah-fly-insert-mode-activate-hook  'my-modeline-color-off)

;; make aliases per this link https://www.youtube.com/watch?v=ufVldIrUOBg
(defalias 'pcr 'package-refresh-contents)
(defalias 'lp 'package-list-packages)
(defalias 'tn 'tab-next)
(defalias 'tp 'tab-previous)
(defalias 'tc 'tab-close)
(defalias 'fsa 'write-file)
(defalias 'jof 'other-frame)
(defalias 'jow 'other-window)

;; prettify dired with icons
(use-package all-the-icons)
(use-package all-the-icons-dired
  :hook
  (dired-mode . all-the-icons-dired-mode))

(use-package dired
  :hook
  (dired-mode . dired-hide-details-mode))

(use-package all-the-icons-completion
  :after (marginalia all-the-icons)
  :hook (marginalia-mode . all-the-icons-completion-marginalia-setup)
  :init (all-the-icons-completion-mode))

(use-package popper
  :ensure t ; or :straight t
  :bind (("C-`"   . popper-toggle)
         ("M-`"   . popper-cycle)
         ("C-M-`" . popper-toggle-type))
  :init
  (setq popper-reference-buffers
        '("\\*Messages\\*"
          "\\*Warnings\\*"
          "Output\\*$"
          "\\*Async Shell Command\\*"
          help-mode
          compilation-mode))
  (setq popper-display-function #'popper-select-popup-at-bottom)
  ;; (setq popper-display-function #'display-buffer-in-child-frame)
  (popper-mode +1)
  (popper-echo-mode +1))                ; For echo area hints

;; #################################################################################
;; copied from emacs-bedrock
;; (setopt initial-major-mode 'fundamental-mode)  ; default mode for the *scratch* buffer
(setopt display-time-default-load-average nil) ; this information is useless for most

;; Automatically reread from disk if the underlying file changes
(setopt auto-revert-avoid-polling t)

;; Make right-click do something sensible
(when (display-graphic-p)
  (context-menu-mode))

(setopt show-trailing-whitespace nil)      ; By default, don't underline trailing spaces
(setopt indicate-buffer-boundaries 'left)  ; Show buffer top and bottom in the margin

;; Display line numbers in programming mode
(add-hook 'prog-mode-hook 'display-line-numbers-mode)
(setopt display-line-numbers-width 3)           ; Set a minimum width

;; Nice line wrapping when working with text
(add-hook 'text-mode-hook 'visual-line-mode)
(add-hook 'org-mode-hook 'visual-line-mode)

;; Modes to highlight the current line with
(let ((hl-line-hooks '(text-mode-hook prog-mode-hook)))
  (mapc (lambda (hook) (add-hook hook 'hl-line-mode)) hl-line-hooks))

;; Enable horizontal scrolling
(setopt mouse-wheel-tilt-scroll t)
(setopt mouse-wheel-flip-direction t)

;; #################################################################################

(use-package org-superstar)
(add-hook 'org-mode-hook (lambda () (org-superstar-mode 1)))

;; added in rhino linux machine for emacs 29.1
(setq warning-minimum-level :error)

;;;; Dired : built-in navigation of folders
(use-package dired
  :ensure nil  ; emacs built-in
  :bind (:map dired-mode-map ("u" . dired-up-directory))
  :custom(dired-kill-when-opening-new-dired-buffer t)) ; Auto close previous folder buffer

;; https://protesilaos.com/emacs/ef-themes#h:dd9e06f2-eef0-4afe-8a12-b7af5d597108
;; add ef-themes
;; Make customisations that affect Emacs faces BEFORE loading a theme
;; (any change needs a theme re-load to take effect).
;; (require 'ef-themes)
(use-package ef-themes)
;; If you like two specific themes and want to switch between them, you
;; can specify them in `ef-themes-to-toggle' and then invoke the command
;; `ef-themes-toggle'.  All the themes are included in the variable
;; `ef-themes-collection'.
(setq ef-themes-to-toggle '(ef-summer ef-winter))

(setq ef-themes-headings ; read the manual's entry or the doc string
      '((0 variable-pitch light 1.9)
        (1 variable-pitch light 1.8)
        (2 variable-pitch regular 1.7)
        (3 variable-pitch regular 1.6)
        (4 variable-pitch regular 1.5)
        (5 variable-pitch 1.4) ; absence of weight means `bold'
        (6 variable-pitch 1.3)
        (7 variable-pitch 1.2)
        (t variable-pitch 1.1)))

;; They are nil by default...
(setq ef-themes-mixed-fonts t
      ef-themes-variable-pitch-ui t)

;; Disable all other themes to avoid awkward blending:
(mapc #'disable-theme custom-enabled-themes)

;; Load the theme of choice:
;; (load-theme 'ef-cherie :no-confirm)

;; OR use this to load the theme which also calls `ef-themes-post-load-hook':
(ef-themes-select 'ef-cherie)

;; The themes we provide are recorded in the `ef-themes-dark-themes',
;; `ef-themes-light-themes'.
;; We also provide these commands, but do not assign them to any key:
;;
;; - `ef-themes-toggle'
;; - `ef-themes-select'
;; - `ef-themes-select-dark'
;; - `ef-themes-select-light'
;; - `ef-themes-load-random'
;; - `ef-themes-preview-colors'
;; - `ef-themes-preview-colors-current'

;; for deadgrep
(global-set-key (kbd "<f6>") nil) ;; unset f6 to give way to deadgrep
(global-set-key (kbd "<f6>") #'deadgrep)

;;;;; Dired-sidebar Configuration
;; https://github.com/danijelcamdzic/dotemacs/blob/main/init.el

(use-package dired-sidebar
  :ensure t
  :config
  ;; Make the window not fixed
  (setq dired-sidebar-window-fixed nil))

;;;;;; Functions - Dired-sidebar toggle

(defun em/dired-sidebar-toggle ()
  "Toggle `dired-sidebar'."
  (interactive)
  (dired-sidebar-toggle-sidebar))

;; enable nix mode
(use-package nix-mode
  :mode "\\.nix\\'")

(use-package w3m
  :ensure t)

;; rewrite this browser setting on 2024-03-15
;; as per this link https://www.emacswiki.org/emacs/BrowseUrl
;; Choosing among various browsers
;; note w3m is installed using nix home-manager

(use-package w3m)
(setq browse-url-browser-function 'browse-url-generic
      browse-url-generic-program "/usr/bin/firefox-beta")

(defun choose-browser (url &rest args)
  "Ask user what browser to open the URL using ARGS."
  (interactive "sURL: ")
  (if (y-or-n-p "Use external browser? ")
      (browse-url-generic url)
    (w3m-browse-url url)))

(setq browse-url-browser-function 'choose-browser)
(global-set-key "\C-xm" 'browse-url-at-point)

(add-hook 'after-init-hook #'(lambda ()
                               (interactive)
                               (require 'server)
                               (or (server-running-p)
                                   (server-start))))


;; sly/slime sbcl section
;; install sly https://github.com/joaotavora/sly
;; https://joaotavora.github.io/sly/#A-SLY-tour-for-SLIME-users
(use-package sly
  :ensure t)
(add-to-list 'exec-path "~/.nix-profile/bin/") ; nixos system
(setq inferior-lisp-program "sbcl")
(add-hook 'sly-mode-hook
          (lambda ()
            (unless (sly-connected-p)
              (save-excursion (sly)))))
(eval-after-load 'sly
  `(define-key sly-prefix-map (kbd "M-h") 'sly-documentation-lookup))

;; Set your lisp system and some contribs
;; (require 'sly-autoloads)
;; (setq sly-contribs '(sly-asdf sly-quicklisp))



;; Enable vertico
(use-package vertico
  :init
  (vertico-mode)

  ;; Different scroll margin
  ;; (setq vertico-scroll-margin 0)

  ;; Show more candidates
  ;; (setq vertico-count 20)

  ;; Grow and shrink the Vertico minibuffer
  ;; (setq vertico-resize t)

  ;; Optionally enable cycling for `vertico-next' and `vertico-previous'.
  ;; (setq vertico-cycle t)
  )

;; Persist history over Emacs restarts. Vertico sorts by history position.
(use-package savehist
  :init
  (savehist-mode))

;; A few more useful configurations...
(use-package emacs
  :init
  ;; Add prompt indicator to `completing-read-multiple'.
  ;; We display [CRM<separator>], e.g., [CRM,] if the separator is a comma.
  (defun crm-indicator (args)
    (cons (format "[CRM%s] %s"
                  (replace-regexp-in-string
                   "\\`\\[.*?]\\*\\|\\[.*?]\\*\\'" ""
                   crm-separator)
                  (car args))
          (cdr args)))
  (advice-add #'completing-read-multiple :filter-args #'crm-indicator)

  ;; Do not allow the cursor in the minibuffer prompt
  (setq minibuffer-prompt-properties
        '(read-only t cursor-intangible t face minibuffer-prompt))
  (add-hook 'minibuffer-setup-hook #'cursor-intangible-mode)

  ;; Support opening new minibuffers from inside existing minibuffers.
  (setq enable-recursive-minibuffers t)

  ;; Emacs 28 and newer: Hide commands in M-x which do not work in the current
  ;; mode.  Vertico commands are hidden in normal buffers. This setting is
  ;; useful beyond Vertico.
  (setq read-extended-command-predicate #'command-completion-default-include-p))

;; Optionally use the `orderless' completion style.
(use-package orderless
  :init
  ;; Configure a custom style dispatcher (see the Consult wiki)
  ;; (setq orderless-style-dispatchers '(+orderless-consult-dispatch orderless-affix-dispatch)
  ;;       orderless-component-separator #'orderless-escapable-split-on-space)
  (setq completion-styles '(orderless basic)
        completion-category-defaults nil
        completion-category-overrides '((file (styles partial-completion)))))

;; Option 1: Additional bindings
(keymap-set vertico-map "?" #'minibuffer-completion-help)
(keymap-set vertico-map "M-RET" #'minibuffer-force-complete-and-exit)
(keymap-set vertico-map "M-TAB" #'minibuffer-complete)

;; Option 2: Replace `vertico-insert' to enable TAB prefix expansion.
;; (keymap-set vertico-map "TAB" #'minibuffer-complete)

;; Use `consult-completion-in-region' if Vertico is enabled.
;; Otherwise use the default `completion--in-region' function.
(setq completion-in-region-function
      (lambda (&rest args)
        (apply (if vertico-mode
                   #'consult-completion-in-region
                 #'completion--in-region)
               args)))

(use-package corfu
  ;; Optional customizations
  ;; :custom
  ;; (corfu-cycle t)                ;; Enable cycling for `corfu-next/previous'
  ;; (corfu-auto t)                 ;; Enable auto completion
  ;; (corfu-separator ?\s)          ;; Orderless field separator
  ;; (corfu-quit-at-boundary nil)   ;; Never quit at completion boundary
  ;; (corfu-quit-no-match nil)      ;; Never quit, even if there is no match
  ;; (corfu-preview-current nil)    ;; Disable current candidate preview
  ;; (corfu-preselect 'prompt)      ;; Preselect the prompt
  ;; (corfu-on-exact-match nil)     ;; Configure handling of exact matches
  ;; (corfu-scroll-margin 5)        ;; Use scroll margin

  ;; Enable Corfu only for certain modes.
  ;; :hook ((prog-mode . corfu-mode)
  ;;        (shell-mode . corfu-mode)
  ;;        (eshell-mode . corfu-mode))

  ;; Recommended: Enable Corfu globally.  This is recommended since Dabbrev can
  ;; be used globally (M-/).  See also the customization variable
  ;; `global-corfu-modes' to exclude certain modes.
  :init
  (global-corfu-mode))

;; A few more useful configurations...
(use-package emacs
  :init
  ;; TAB cycle if there are only few candidates
  ;; (setq completion-cycle-threshold 3)

  ;; Enable indentation+completion using the TAB key.
  ;; `completion-at-point' is often bound to M-TAB.
  (setq tab-always-indent 'complete)

  ;; Emacs 30 and newer: Disable Ispell completion function. As an alternative,
  ;; try `cape-dict'.
  (setq text-mode-ispell-word-completion nil)

  ;; Emacs 28 and newer: Hide commands in M-x which do not apply to the current
  ;; mode.  Corfu commands are hidden, since they are not used via M-x. This
  ;; setting is useful beyond Corfu.
  (setq read-extended-command-predicate #'command-completion-default-include-p))



;; begin config denote note-taking
(use-package denote
  :init
  (add-hook 'find-file-hook #'denote-link-buttonize-buffer)
  (add-hook 'dired-mode-hook #'denote-dired-mode-in-directories)
  ;; Remember to check the doc strings of those variables.
  (setq denote-directory (expand-file-name "~/.emacs.d/notes"))
  (setq denote-known-keywords '("emacs" "philosophy" "linux" "todo" "coding" "priv" "cli" "technology" "economy" "bsd" "climate" "news"))
  (setq denote-infer-keywords t)
  (setq denote-sort-keywords t)
  (setq denote-file-type nil) ; Org is the default, set others here
  (setq denote-prompts '(title keywords))
  (setq denote-excluded-directories-regexp nil)
  (setq denote-excluded-keywords-regexp nil)
  (setq denote-date-prompt-use-org-read-date t)
  (setq denote-date-format nil)
  (setq denote-backlinks-show-context t)
  ;; We use different ways to specify a path for demo purposes.
  (setq denote-dired-directories
        (list denote-directory
              (thread-last denote-directory (expand-file-name "attachments"))
              (expand-file-name "~/.emacs.d/books")))
  :config
  (denote-rename-buffer-mode 1))

;; Denote DOES NOT define any key bindings.  This is for the user to
;; decide.  For example:
(let ((map global-map))
  (define-key map (kbd "C-c n n") #'denote)
  (define-key map (kbd "C-c n c") #'denote-region) ; "contents" mnemonic
  (define-key map (kbd "C-c n N") #'denote-type)
  (define-key map (kbd "C-c n d") #'denote-date)
  (define-key map (kbd "C-c n z") #'denote-signature) ; "zettelkasten" mnemonic
  (define-key map (kbd "C-c n s") #'denote-subdirectory)
  (define-key map (kbd "C-c n t") #'denote-template)
  ;; If you intend to use Denote with a variety of file types, it is
  ;; easier to bind the link-related commands to the `global-map', as
  ;; shown here.  Otherwise follow the same pattern for `org-mode-map',
  ;; `markdown-mode-map', and/or `text-mode-map'.
  (define-key map (kbd "C-c n i") #'denote-link) ; "insert" mnemonic
  (define-key map (kbd "C-c n I") #'denote-add-links)
  (define-key map (kbd "C-c n b") #'denote-backlinks)
  (define-key map (kbd "C-c n f f") #'denote-find-link)
  (define-key map (kbd "C-c n f b") #'denote-find-backlink)
  ;; Note that `denote-rename-file' can work from any context, not just
  ;; Dired bufffers.  That is why we bind it here to the `global-map'.
  (define-key map (kbd "C-c n r") #'denote-rename-file)
  (define-key map (kbd "C-c n R") #'denote-rename-file-using-front-matter))

;; Key bindings specifically for Dired.
(let ((map dired-mode-map))
  (define-key map (kbd "C-c C-d C-i") #'denote-link-dired-marked-notes)
  (define-key map (kbd "C-c C-d C-r") #'denote-dired-rename-files)
  (define-key map (kbd "C-c C-d C-k") #'denote-dired-rename-marked-files-with-keywords)
  (define-key map (kbd "C-c C-d C-R") #'denote-dired-rename-marked-files-using-front-matter))

(with-eval-after-load 'org-capture
  (setq denote-org-capture-specifiers "%l\n%i\n%?")
  (add-to-list 'org-capture-templates
               '("n" "New note (with denote.el)" plain
                 (file denote-last-path)
                 #'denote-org-capture
                 :no-save t
                 :immediate-finish nil
                 :kill-buffer t
                 :jump-to-captured t)))

;; Also check the commands `denote-link-after-creating',
;; `denote-link-or-create'.  You may want to bind them to keys as well.

;; If you want to have Denote commands available via a right click
;; context menu, use the following and then enable
;; `context-menu-mode'.
(add-hook 'context-menu-functions #'denote-context-menu)

;; Enable rich annotations using the Marginalia package
(use-package marginalia
  ;; Bind `marginalia-cycle' locally in the minibuffer.  To make the binding
  ;; available in the *Completions* buffer, add it to the
  ;; `completion-list-mode-map'.
  :bind (:map minibuffer-local-map
              ("M-A" . marginalia-cycle))

  ;; The :init section is always executed.
  :init

  ;; Marginalia must be activated in the :init section of use-package such that
  ;; the mode gets enabled right away. Note that this forces loading the
  ;; package.
  (marginalia-mode))

(all-the-icons-completion-mode)
(add-hook 'marginalia-mode-hook #'all-the-icons-completion-marginalia-setup)

;; eat terminal emulator
(use-package eat
  :ensure t)

(use-package howm) ; https://www.emacswiki.org/emacs/HowmMode

;; calendar/diary customizations
(setq calendar-week-start-day 1) ; begin on Monday
(setq calendar-weekend-days '(6 7))


(provide 'init-local.el)
;;; init-local.el ends here
