;;; package --- Summary
;;; Commentary:
;;; todo how to insert date? create your own function or copy from emacswiki using eww
;;; https://www.emacswiki.org/emacs/InsertingTodaysDate

(defun insert-standard-date ()
  "Insert standard date time string." 
  (interactive)
  (insert (format-time-string "%c")))

;; output -> Wed 27 Sep 2023 06:58:00 AM +03

;; Using the Shell to Insert the Date

(defun insert-current-date () (interactive)
       (insert (shell-command-to-string "echo -n $(date +%Y-%m-%d)")))

;; Or

;; `C-u M-! date +"%B %e, %Y" RET'

;; 2023-09-27
;; 2023-09-28


(require 'calendar)
(defun insdate-insert-current-date (&optional OMIT-DAY-OF-WEEK-P)
  "Insert today's date using the current locale.
  With a prefix argument OMIT-DAY-OF-THE-WEEK-P, the date is inserted
   without the day of the week."
  (interactive "P*")
  (insert (calendar-date-string (calendar-current-date) nil
				OMIT-DAY-OF-WEEK-P)))

;; Thursday, September 28, 2023
;; TIP: you can put these in a org code block and output it anywhere you want

;; Thu 28 Sep 2023 05:03:42 AM +03
(provide 'sample-date-snippets)
;;; sample-date-snippets.el ends here
