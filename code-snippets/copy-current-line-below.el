;;; Package --- summary:
;;; Commentary:
;;; How to insert file name
;; in the current line
;; https://www.youtube.com/watch?v=IbrgXydt6iM

(defun copy-current-line-below ()
  "Copy current line and put it below with point in the same position"
  (interactive)
  (let ((line (buffer-substring (point-at-bol) (point-at-eol))))
    (save-excursion
      (forward-line)
      (insert line "\n"))))

;;; note: the 2 lines below are saved as t in the register fyi.
;;; Package --- summary:
;;; TODO: how to insert file name in the buffer you are in?
;;; then insert the kw provide to comply to the flymake warning msg
;;; check this out https://www.emacswiki.org/emacs/InsertFileName

(provide 'copy-current-line-below)
;;; copy-current-line-below.el ends here
