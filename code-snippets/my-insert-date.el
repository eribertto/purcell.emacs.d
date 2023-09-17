;;; my-insert-date.el --- insert date
;;; Commentary:
;;; Code:





;; practice inserting date and time

(defun insert-standard-date ()
  "Insert standard date time string."
  (interactive)
  (insert (format-time-string ";; %A %F")))

;; 2023-09-17
;; 17 2023-09-17

;; Sun 17 Sep 2023 04:29:26 AM +03
;; 09/17/23

;; Sunday 2023-09-17
;; TODO: to insert commentary template just copy from existing Purcell codes
;; then save it as region of text and insert it everytime you create an elisp code
;; Idea https://www.emacswiki.org/emacs/CommentingCode
;;; Also check out the help system search for comment aka C-h a comment
;;; NOTE: code-snippets dir is not in emacs PATH

(provide 'my-insert-date)
;;; my-insert-date.el ends here
