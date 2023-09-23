;;; package --- summary init-local.el
;;; Code:
;;; Commentary:
;;; This is the users personal settings override

(vertico-mode)
(desktop-save-mode 1)
(menu-bar-mode)
(blink-cursor-mode 1)
(turn-on-visual-line-mode)

(add-to-list 'load-path (expand-file-name "code-snippets" user-emacs-directory))

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
                 (load-theme 'modus-vivendi)))
(if (string= (system-name)
             "eribertto-nuc7i5bnh")
    (add-to-list 'default-frame-alist '(cursor-color . "white")
                 (load-theme 'ef-night)))
;; why does flymake flagged require popper an error?
(require 'popper)
(setq popper-reference-buffers
      '("\\*Messages\\*"
        "Output\\*$"
        "\\*Async Shell Command\\*"
        "\\*Compile-Log\\*"
        help-mode
        compilation-mode))
(global-set-key (kbd "C-`") 'popper-toggle)
(global-set-key (kbd "M-`") 'popper-cycle)
(global-set-key (kbd "C-M-`") 'popper-toggle-type)
(popper-mode +1)

;; For echo-area hints
(require 'popper-echo)
(popper-echo-mode +1)

(when (display-graphic-p)
  (require 'all-the-icons))

;;; some Org overrides
;;; this replaces some defaults in init-org.el
(require 'org-bullets)
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

(provide 'init-local)
;;; init-local.el ends here
