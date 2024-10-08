;;; init-local.el --- Configure default locale -*- lexical-binding: t -*-
;;; Commentary:
;;; Code:



;; https://www.emacswiki.org/emacs/VisualLineMode
(add-hook 'text-mode-hook 'turn-on-visual-line-mode)
(setq visual-line-fringe-indicators '(left-curly-arrow right-curly-arrow))
;;    copied from bedrock-emacs
;;    https://melpa.org/#/getting-started

(with-eval-after-load 'package
  (add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t))

;; occurkey https://www.emacswiki.org/emacs/OccurKey
(defun my-occur ()
  "Switch to *Occur* buffer, or run `occur'."
  (interactive)
  (if (get-buffer "*Occur*")
      (switch-to-buffer-other-window "*Occur*")
    (call-interactively 'occur)))

(global-set-key (kbd "C-c o") 'my-occur)

;; kill occur buffer
(global-set-key (kbd "C-c C-M-o")
                '(lambda ()
                   "Kill the *Occur* buffer"
                   (interactive)
                   (kill-buffer "*Occur*")
                   (delete-other-windows)))

;; install packages using loop
(dolist (package '(markdown-mode  hyperbole deadgrep nix-mode w3m ef-themes dired-sidebar denote paredit rainbow-delimiters popper all-the-icons all-the-icons-dired all-the-icons-completion marginalia vertico orderless corfu magit org-superstar org-super-agenda sly eglot eat  savehist vundo olivetti)
                 )
  (unless (package-installed-p package)
    (package-install package)))

;; cperl mode https://www.emacswiki.org/emacs/CPerlMode#h5o-1
(add-to-list 'major-mode-remap-alist '(perl-mode . cperl-mode))

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


(menu-bar-mode t)
(desktop-save-mode t)
;; (desktop-load-locked-desktop t)
;; Show the tab-bar as soon as tab-bar functions are invoked
(setq tab-bar-tab-hints t)
(setq tab-bar-close-button-show t)


(setq fill-column 100) ;; ditch the default 70, we're 2023 now.

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

  ;; (add-hook 'find-file-hook #'denote-link-buttonize-buffer)
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

;; note org-superstar.el is placed under lisp dir
;; (require 'org-superstar)
(use-package org-superstar)
(add-hook 'org-mode-hook (lambda () (org-superstar-mode 1)))

;; (define-key inferior-emacs-lisp-mode-map
;;             (kbd "C-c C-q")
;;             #'ielm/clear-repl
;;             )

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

(use-package w3m)
(setq browse-url-browser-function 'browse-url-generic
      browse-url-generic-program "/usr/bin/firefox")

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


;; show/hide gui functions
(defun em/gui-hide-bars ()
  "Disable scroll bar, menu bar, and tool bar."
  (interactive)
  (scroll-bar-mode -1)
  (menu-bar-mode -1)
  (tool-bar-mode -1))

(defun em/gui-show-bars ()
  "Enable scroll bar, menu bar, and tool bar."
  (interactive)
  (scroll-bar-mode 1)
  (menu-bar-mode 1)
  (tool-bar-mode -1))

(use-package nix-mode
  :mode "\\.nix\\'")

(use-package org-web-tools
  :ensure t)

(provide 'init-local)
;;; init-local.el ends here
