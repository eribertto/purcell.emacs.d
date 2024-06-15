;;; init-local.el --- Configure default locale -*- lexical-binding: t -*-
;;; Commentary:
;;; Code:

;;    copied from bedrock-emacs
;;    https://melpa.org/#/getting-started
;; You can simply uncomment the following if you'd like to get started with
;; MELPA packages quickly:
;;
(with-eval-after-load 'package
  (add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t))

;; install packages using loop
(dolist (package '(markdown-mode pdf-tools hyperbole deadgrep nix-mode w3m ef-themes dired-sidebar denote paredit rainbow-delimiters xah-fly-keys popper all-the-icons all-the-icons-dired all-the-icons-completion marginalia vertico orderless corfu magit org-superstar org-super-agenda sly eglot eat racket-mode geiser geiser-racket scribble-mode savehist vundo olivetti)
                 )
  (unless (package-installed-p package)
    (package-install package)))

;; add own personal lisp codes here
;; setup frame font including minibuffer and modeline
;; http://xahlee.info/emacs/emacs/emacs_list_and_set_font.html

;; http://xahlee.info/emacs/misc/xah-fly-keys.html
(add-to-list 'load-path "~/.emacs.d/xah-fly-keys")
(use-package xah-fly-keys
  :config
  (xah-fly-keys-set-layout "qwerty")
  (xah-fly-keys 1))

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

;; (fit-frame-to-buffer)
;; (auto-save-visited-mode)
;; NOTE: ‘auto-save-visited-interval’ value is now 45 from 5 2024-03-23
(menu-bar-mode 1)
(desktop-save-mode 1)

;;(tab-bar-mode 1)
;; Show the tab-bar as soon as tab-bar functions are invoked
;; (setopt tab-bar-show 1)
(setq tab-bar-tab-hints 1)
(setq tab-bar-close-button-show t)

(setq fill-column 100) ;; ditch the default 70, we're 2024 now.

;; begin customization of xah fly keys
;; add global toggle key command/insert mode
;; note F4 is taken so use F5 instead

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

;; setup unicode as per this link
;; http://xahlee.info/emacs/emacs/emacs_set_font_symbol.html
;; symbola-font and JuliaMono are installed via apt-get
(set-fontset-font t 'symbol
                  (cond
                   ((eq system-type 'windows-nt)
                    (cond
                     ((member "Segoe UI Symbol" (font-family-list)) "Segoe UI Symbol")))
                   ((eq system-type 'darwin)
                    (cond
                     ((member "Apple Symbols" (font-family-list)) "Apple Symbols")))
                   ((eq system-type 'gnu/linux)
                    (cond
                     ((member "Symbola" (font-family-list)) "Symbola")))))
    ;; ((member "JuliaMono" (font-family-list)) "JuliaMono")))))

;; make aliases per this link https://www.youtube.com/watch?v=ufVldIrUOBg
(defalias 'pcr 'package-refresh-contents)
(defalias 'lp 'package-list-packages)
(defalias 'tn 'tab-next)
(defalias 'tp 'tab-previous)
(defalias 'tc 'tab-close)
(defalias 'fsa 'write-file)
(defalias 'jof 'other-frame)
(defalias 'jow 'other-window)




;; https://www.emacswiki.org/emacs/Scrolling
;; page scroll by 30 lines increment
;; (global-set-key "\M-n"  (lambda () (interactive) (scroll-up   30)) )
;; (global-set-key "\M-h"  (lambda () (interactive) (scroll-down 30)) )

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
  (require 'pdf-info)
  (require 'pdf-isearch)
  (require 'pdf-history)
  (require 'pdf-links)
  (pdf-tools-install :noquery))

;; (pdf-tools-install :no-query))

;; popper entries
;; https://mirrors.zju.edu.cn/elpa/gnu/popper.html

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

;; doom-modeline
;; (use-package doom-modeline
;;   :ensure t
;;   :hook (after-init . doom-modeline-mode))

;; note org-superstar.el is placed under lisp dir
;; (require 'org-superstar)
(use-package org-superstar)
(add-hook 'org-mode-hook (lambda () (org-superstar-mode 1)))


;; http://caiorss.github.io/Emacs-Elisp-Programming/Elisp_Programming.html#sec-1-4-1

(require 'ielm)

(defun ielm/clear-repl ()
  "Clear current REPL buffer."
  (interactive)
  (let ((inhibit-read-only t))
    (erase-buffer)
    (ielm-send-input)))

(define-key inferior-emacs-lisp-mode-map
            (kbd "M-RET")
            #'ielm-return)

(define-key inferior-emacs-lisp-mode-map
            (kbd "C-j")
            #'ielm-return)

(define-key inferior-emacs-lisp-mode-map
            (kbd "RET")
            #'electric-newline-and-maybe-indent)

(define-key inferior-emacs-lisp-mode-map
            (kbd "<up>")
            #'previous-line)

(define-key inferior-emacs-lisp-mode-map
            (kbd "<down>")
            #'next-line)

(define-key inferior-emacs-lisp-mode-map
            (kbd "C-c C-q")
            #'ielm/clear-repl
            )

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
(load-theme 'ef-cherie :no-confirm)

;; OR use this to load the theme which also calls `ef-themes-post-load-hook':
;; (ef-themes-select 'ef-summer)

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

;; Elfeed basic entries
(setq elfeed-feeds
      '("https://planet.emacslife.com/atom.xml"
        "https://www.reddit.com/r/emacs.rss"
        "https://www.reddit.com/r/orgmode.rss"
        "https://blog.tecosaur.com/tmio/rss.xml"
        "http://oremacs.com/atom.xml"))

(setf url-queue-timeout 30)

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

;;;; Visual Modes
;; Enable outline-minor-mode as soon as .el file is opened
(add-hook 'emacs-lisp-mode-hook 'outline-minor-mode)


;; enable nix mode
(use-package nix-mode
  :mode "\\.nix\\'")

;; (global-org-modern-mode-enable-in-buffers)
;; (org-roam-mode)

;; (defun org-agenda-open-hook ()
;;   ;; Turn on Olivetti mode."
;;   olivetti-mode)
;; (add-hook 'org-agenda-mode-hook 'org-agenda-open-hook)

(use-package org-super-agenda)
(org-super-agenda-mode)

;; this is a sample code snippet from org-super-agenda
;; https://github.com/alphapapa/org-super-agenda


(let ((org-super-agenda-groups
       '(;; Each group has an implicit boolean OR operator between its selectors.
         (:name "Today"           ; Optionally specify section name
                :time-grid t      ; Items that appear on the time grid
                :todo "TODAY")    ; Items that have this TODO keyword
         (:name "Important"
                ;; Single arguments given alone
                :tag "bills"
                :priority "A")
         ;; Set order of multiple groups at once
         (:order-multi (2 (:name "Shopping in town"
                                 ;; Boolean AND group matches items that match all subgroups
                                 :and (:tag "shopping" :tag "@town"))
                          (:name "Food-related"
                                 ;; Multiple args given in list with implicit OR
                                 :tag ("food" "dinner"))
                          (:name "Personal"
                                 :habit t
                                 :tag "personal")
                          (:name "Space-related (non-moon-or-planet-related)"
                                 ;; Regexps match case-insensitively on the entire entry
                                 :and (:regexp ("space" "NASA")
                                               ;; Boolean NOT also has implicit OR between selectors
                                               :not (:regexp "moon" :tag "planet")))))
         ;; Groups supply their own section names when none are given
         (:todo "WAITING" :order 8)     ; Set order of this section
         (:todo ("SOMEDAY" "TO-READ" "CHECK" "TO-WATCH" "WATCHING")
                ;; Show this group at the end of the agenda (since it has the
                ;; highest number). If you specified this group last, items
                ;; with these todo keywords that e.g. have priority A would be
                ;; displayed in that group instead, because items are grouped
                ;; out in the order the groups are listed.
                :order 9)
         (:priority<= "B"
                      ;; Show this section after "Today" and "Important", because
                      ;; their order is unspecified, defaulting to 0. Sections
                      ;; are displayed lowest-number-first.
                      :order 1)
         ;; After the last group, the agenda will display items that didn't
         ;; match any of these groups, with the default order position of 99
         )))
  (org-agenda nil "a"))

(use-package vundo
  :ensure t)
(setq vundo-glyph-alist vundo-unicode-symbols)

(use-package hyperbole
  :ensure t
  :config
  (hyperbole-mode))

(use-package w3m
  :ensure t)

;; rewrite this browser setting on 2024-03-15
;; as per this link https://www.emacswiki.org/emacs/BrowseUrl
;; Choosing among various browsers
;; note w3m is installed using nix home-manager



;; (setq
;;  browse-url-browser-function 'eww-browse-url ; Use eww as the default browser
;;  shr-use-fonts  nil                          ; No special fonts
;;  shr-use-colors nil                          ; No colours
;;  shr-indentation 2                           ; Left-side margin
;;  shr-width 80                                ; Fold text to specified columns
;;  eww-search-prefix "https://wiby.me/?q=")    ; Use another engine for searching

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

;; ;; (require 'egg-timer)
;; (use-package egg-timer)
;; (global-set-key (kbd "C-s-a") #'egg-timer-schedule)

(add-hook 'after-init-hook #'(lambda ()
                               (interactive)
                               (require 'server)
                               (or (server-running-p)
                                   (server-start))))

(add-to-list 'exec-path "~/.nix-profile/bin")
(setq inferior-lisp-program "sbcl")

;; install sly https://github.com/joaotavora/sly
;; https://joaotavora.github.io/sly/#A-SLY-tour-for-SLIME-users

(use-package sly
  :ensure t)

(eval-after-load 'sly
  `(define-key sly-prefix-map (kbd "M-h") 'sly-documentation-lookup))

;; https://www.quicklisp.org/beta/
;; Make sure to follow the quicklisp install link above.


(provide 'init-local)
;;; init-local.el ends here
