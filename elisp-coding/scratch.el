;; Chapter 3 How to write function definitions
;; An introduction to Programming in Emacs Lisp
;; 2024-02-23

(defun multiply-by-seven (number)
  "Multiply the NUMBER by 7."
  (interactive "p") ;; interactive version
  (message "The result is %d" (* 7 number)))


