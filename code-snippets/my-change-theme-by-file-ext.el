;; Happy hacking, eriberttom - Emacs ♥ you!
;; http://xahlee.info/emacs/emacs/emacs_set_theme_on_mode.html

(defun my-set-theme-on-mode ()
  "set background color or theme depending on file suffix"
  (interactive)
  (let* (($bfn (buffer-file-name))
         ($fileNameExt (if $bfn
                           (file-name-extension $bfn)
                         nil
                         )))
    (cond
     ((not $fileNameExt) nil)
     ((string-equal $fileNameExt "el")
      (progn
        (set-background-color "honeydew")))
     ((string-equal $fileNameExt "txt")
      (progn
        (set-background-color "cornsilk")))
     ((string-equal $fileNameExt "js")
      (progn
        (load-theme 'tango t)))
     ((string-equal $fileNameExt "ts")
      (progn
        (load-theme 'tango t)))
     ((string-equal $fileNameExt "html")
      (progn
        (load-theme 'light-blue t)))
     ((string-equal $fileNameExt "css")
      (progn
        (load-theme 'tango-dark t)))
     (t nil))))

(add-hook 'find-file-hook 'my-set-theme-on-mode)
(add-hook 'kill-buffer-hook 'my-set-theme-on-mode)

;; need to add hook to
;; switch buffer
;; switch frame
;; switch window
