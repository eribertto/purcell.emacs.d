;;; package --- summary init-local.el
;;; Code:
;;; Commentary:
;;; This is the users personal settings override

(vertico-mode 1)
(desktop-save-mode 1)
(menu-bar-mode)
(blink-cursor-mode 1)
(turn-on-visual-line-mode)
;;(set-cursor-color cyan)

(add-to-list 'load-path (expand-file-name "elpa-29.1/xah-fly-keys-24.13.20231005090319" user-emacs-directory))

(with-eval-after-load 'org (global-org-modern-mode))

;; (add-to-list 'load-path "~/.emacs.d/elpa-29.1")
;; 10/3/23 try out xah-fly-keys
;; (require 'xah-fly-keys)
(use-package xah-fly-keys
  :config
  (xah-fly-keys-set-layout "qwerty")
  (xah-fly-keys 1))
;; (xah-fly-keys-set-layout "qwerty")
;; (xah-fly-keys 1)

;; Use Emacs or w3m as browser, xah lee has some tips to this
(setq browse-url-browser-function 'eww-browse-url)

;;; add to emacs path the users hand made code snippets
;;; https://www.emacswiki.org/emacs/LoadPath
;; (add-to-list 'load-path "~/.emacs.d/code-snippets")

;;; (setq browse-url-browser-function 'w3m-browse-url)
;;; (require 'w3m-load)
;; TODO consider if to install wanderlust or no
;; https://github.com/wanderlust/wanderlust
;; try out emacs transparency as per EmacsWiki guide
;; Fri 01 Sep 2023 04:38:27 AM +03
(set-frame-parameter nil 'alpha-background 80)
(add-to-list 'default-frame-alist '(alpha-background . 80))

;; some hooks
(add-hook 'diary-mode (lambda) (auto-save-visited-mode))
(add-hook 'todo-mode (lambda) (auto-save-visited-mode))
(add-hook 'dired-mode-hook 'all-the-icons-dired-mode)

(require-theme 'modus-themes)
;; (load-theme 'modus-operandi)
(if (string= (system-name) "TP460-eos")
    (add-to-list 'default-frame-alist '(cursor-color . "yellow")
                 (load-theme 'modus-vivendi-tinted)))
(if (string= (system-name)
             "eribertto-nuc7i5bnh")
    (add-to-list 'default-frame-alist '(cursor-color . "white")
                 (load-theme 'ef-night)))
;; why does flymake flagged require popper an error?
;; (require 'popper)
(use-package popper)
(setq popper-reference-buffers
      '("\\*Messages\\*"
        "Output\\*$"
        "\\*Async Shell Command\\*"
        "\\*Compile-Log\\*"
        "\\*Warnings\\*"
        help-mode
        compilation-mode))
(global-set-key (kbd "C-`") 'popper-toggle)
(global-set-key (kbd "M-`") 'popper-cycle)
(global-set-key (kbd "C-M-`") 'popper-toggle-type)
(popper-mode +1)

;; For echo-area hints
;; (require 'popper-echo)
(use-package popper-echo
  :config
  popper-echo-mode 1)

(when (display-graphic-p)
  (require 'all-the-icons))

;;; some Org overrides
;;; this replaces some defaults in init-org.el
;; (require 'org-bullets)
(use-package org-bullets)
(add-hook 'org-mode-hook (lambda () (org-bullets-mode 1)))

(setq org-default-notes-file "~/.emacs.d/notes/tasks.org")
(setq org-capture-templates
      '(("t" "Personal Todo/Tasks" entry (file+headline "" "Inbox") ; use the default
         "* TODO %?\n%U")
        ("n" "Note" entry  (file+headline "" "Notes")
         "* %? :NOTE:\nEntry date %U\n %i\n %a")
        ("j" "Journal" entry (file+datetree "~/.emacs.d/notes/journal.org")
         "* %?\nEntry date %U\n %i\n %a")))

;; function for line wrapping
(defun setup-textorg-mode ()
  "Set some variables when in text or org mode."
  (set-fill-column 80)
  (column-number-mode 1)
  (flymake-mode nil)
  (visual-line-mode)
  (setq truncate-lines t))

(add-hook 'text-mode-hook
          'setup-textorg-mode
          'my-set-theme-on-mode) ;; this doesnt work it seems 9/23/23
(add-hook 'org-mode-hook 'setup-textorg-mode)

;; for w3m from emacswiki.org/emacs/emacs-w3m
;; TODO: make this a conditional using (system-name) function
;; since this conflicts with eww above
;;(setq browse-url-browser-function 'w3m-browse-url)
;;
(autoload 'w3m-browse-url "w3m" "Ask the WWW browser to show a URL" t)

;; for literate programming from guide howardism.org
(setq org-confirm-babel-evaluate nil
      org-src-fontify-natively t
      org-src-tab-acts-natively t)

;; setup burly and quelpa 9/26/23
;; https://github.com/quelpa/quelpa-use-package
;; https://github.com/alphapapa/burly.el
;; https://github.com/quelpa/quelpa

(unless (package-installed-p 'quelpa)
  (with-temp-buffer
    (url-insert-file-contents "https://raw.githubusercontent.com/quelpa/quelpa/master/quelpa.el")
    (eval-buffer)
    (quelpa-self-upgrade)))

(quelpa
 '(quelpa-use-package
   :fetcher git
   :url "https://github.com/quelpa/quelpa-use-package.git"))
;; (require 'quelpa-use-package)
(use-package quelpa-use-package)

(use-package burly
  :quelpa (burly :fetcher github :repo "alphapapa/burly.el"))

;; Read ePub files
(use-package nov
  :init
  (add-to-list 'auto-mode-alist '("\\.epub\\'" . nov-mode)))

(use-package eshell-syntax-highlighting
  :after eshell-mode
  :ensure t ;; Install if not already installed.
  :config
  ;; Enable in all Eshell buffers.
  (eshell-syntax-highlighting-global-mode +1))

;; after emacs24.4
;; https://www.masteringemacs.org/article/complete-guide-mastering-eshell
(with-eval-after-load "esh-opt"
  (autoload 'epe-theme-lambda "eshell-prompt-extras")
  (setq eshell-highlight-prompt nil
        eshell-prompt-function 'epe-theme-lambda))
;; epe-theme-lambda
;; epe-theme-dakrone
(setq epe-theme-multiline-with-status t)

(fit-frame-to-buffer)
;; copied from xah-fly-keys init.el repo 2023-11-18
;; (server-start)
;; (server-mode 1)
;; UTF-8 as default encoding
(set-language-environment 'utf-8)
(set-default-coding-systems 'utf-8)
(set-keyboard-coding-system 'utf-8-unix)
;; keep a list of recently opened files
(require 'recentf)
(recentf-mode 1)
;; xah lees guide http://xahlee.info/emacs/emacs/keyboard_shortcuts.html
;; keybinding shortcuts syntax for emacs 29
(keymap-global-set "C-^" #'tab-previous)
(keymap-global-set "C-&" #'tab-next)
(global-set-key (kbd "<f5>") 'xah-fly-mode-toggle) ; this works

;; add a key to insert mode to activate command mode sort of jk escape in vim
;; note the term 'a key' meaning only one key char
;; use target key \ aka forward slash but
;; note to use this literal char (in insert mode) hit C-q first

(define-key xah-fly-insert-map (kbd "\\") 'xah-fly-command-mode-activate)
;; (global-set-key (kbd "\\") 'xah-fly-command-mode-activate)
;; insert by doing C-q first then the character \  (in insert mode)
;; modeline colors and icons
;; command-mode-indicator-symbols = "" " "
;; icons copied from toml file of starship.rs themes
(setq xah-fly-command-mode-indicator " ")
(setq xah-fly-insert-mode-indicator "✏" )
;; (defun my-modeline-color-on () (set-face-background 'mode-line "green"))
(defun my-modeline-color-on () (set-face-background 'mode-line "royal blue"))
(defun my-modeline-color-off () (set-face-background 'mode-line "tomato"))
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

;; end config denote note-taking

;; #################################################################################
;; begin snippets emacs-bedrock
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

;; Show the tab-bar as soon as tab-bar functions are invoked
;; (setopt tab-bar-show 1)

;; Enable horizontal scrolling
(setopt mouse-wheel-tilt-scroll t)
(setopt mouse-wheel-flip-direction t)

;; end snippets emacs-bedrock
;; #################################################################################

(use-package pdf-tools
  :demand t
  :hook (TeX-after-compilation-finished . TeX-revert-document-buffer)
  :mode ("\\.pdf\\'" . pdf-view-mode)
  :config
  (require 'pdf-tools)
  (require 'pdf-view)
  (require 'pdf-misc)
  (require 'pdf-occur)
  (require 'pdf-util)
  (require 'pdf-annot)
  ;; (require 'pdf-info)
  (require 'pdf-isearch)
  (require 'pdf-history)
  (require 'pdf-links)
  (pdf-tools-install :no-query))

;; install doom-modeline
(use-package doom-modeline
  :ensure t
  :hook (after-init . doom-modeline-mode))




(provide 'init-local)
;;; init-local.el ends here
