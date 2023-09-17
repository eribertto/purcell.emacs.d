;;; Package --- summary:
;;; Commentary:
;;; Code:
;;; How to insert file name
;; in the current line
;;; https://www.emacswiki.org/emacs/InsertFileName

(defun my-insert-file-name (filename &optional args)
  "Insert name of FILENAAME into buffer after the point.
Prefixed with \\[universal-argument], expand the file name to
its fully canonicalized path. See 'expand-file-name'.
Prefixed with \\[negative-argument], use relative path to file
name from current directory, 'default-directory'. See 
'file-relative-name'.
The default with no prefix is to insert the file anme exactly as
it appears in the minibuffer prompt."
  ;; Based on insert-file in Emacs
  (interactive "*fInsert file name: \nP")
  (cond ((eq '- args)
         (insert (vc-bzr-file-name-relative filename)))
        ((not (null args))
         (insert (expand-file-name filename)))
        (t (insert filename))))

;; TODO: this keychord seems like error
;; (global-set-key "C-c\C-i" 'my-insert-file-name)
;; TIP have a look at diff kbd setup in emacs repos locally
;; TIP also do readup of the function kbd and work out something.
(provide 'insert-file-name.el)
;;; insert-file-name.el ends here
