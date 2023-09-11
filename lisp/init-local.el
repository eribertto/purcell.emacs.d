;;; package --- summary of package
;;; Code:
;;; Commentary:
;;; your personal settings go here

;; (popper-mode)
;;;Make emacs always use its own browser for opening URLs
(setq browse-url-browser-function 'eww-browse-url)
(desktop-save-mode 1)
(menu-bar-mode)

;; try out emacs transparency as per EmacsWiki guide
;; Fri 01 Sep 2023 04:38:27 AM +03
(set-frame-parameter nil 'alpha-background 75)
(add-to-list 'default-frame-alist '(alpha-background . 75))

;; auto save hooks
(add-hook 'diary-mode (lambda) (auto-save-visited-mode))
(add-hook 'todo-mode (lambda) (auto-save-visited-mode))
(add-hook 'dired-mode-hook 'all-the-icons-dired-mode)


;; example snippet of determining major mode
;; you can check the buffers major mode by doing M-x: major-mode <enter>
;; (if (eq major-mode 'lisp-interaction-mode)
;;     (message "Yes you are!")
;;   (message "No you're not!"))
(blink-cursor-mode 1)


(if (string= (system-name) "TP460-eos")
    (add-to-list 'default-frame-alist '(cursor-color . "yellow")))

(turn-on-visual-line-mode)

(require 'popper)
(setq popper-reference-buffers
      '("\\*Messages\\*"
        "Output\\*$"
        "\\*Async Shell Command\\*"
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

;; shorten the ls mode of dired
;; (dired-hide-details-mode +1)

;;; edit to follow this tutorial
;;; https://howardism.org/Technical/Emacs/capturing-intro.html
;;; 9/11/23 TODO: how to insert date stamp

;;; this overrides the default variable in init-org.el
(setq org-default-notes-file "~/.emacs.d/notes/tasks.org")
(setq org-capture-templates
      '(("t" "Personal Tasks" entry (file "") ; use the default
         "* TODO %?\n%U\n" :clock-resume t)
        ("n" "Note" entry  (file "")
         "* %? :NOTE:\n%U\n%a\n" :clock-resume t)))



(provide 'init-local)
;;; init-local.el ends here
