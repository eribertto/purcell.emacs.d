;;; package --- Summary
;;; Commentary:
;;; Happy hacking, eriberttom - Emacs ♥ you!

(insert (buffer-file-name (current-buffer)))
;; /home/eriberttom/.emacs.d/code-snippets/practice.elisp.el

(defun buffer/insert-filename ()
  "Insert file name of current buffer at current point"

  (interactive)
  (insert (buffer-file-name (current-buffer))))

;; /home/eriberttom/.emacs.d/code-snippets/practice.elisp.el

;; more/less than
(> 10 100) ;; nil or false
(< 10 100) ;; t
;; equality numbers
(= 2 2) ;; t
(= 20 20.00) ;; integer and float are the same
;; compare elements of a list
(equal (list 1 2 3 4 5) (list 1 2 3 4 5)) ;; yes t
(string= "hello" "hello") ;; t
;; string and numbers literals
1e3
"Hello World Emacs Literals"
;; symbol
'this-a-symbol
'vector->list
;; boolean t or nil aka false
t ;;everything that is not nil is true
nil ;; nil
() ;; nil or anything empty
(if t "it is true (not nil)" "it is false (or nil)")
100e3 ;; 100000.0
(if 100e3 "it is true (not nil)" "it is false (aka nil")
;; pair / cons cell (RTFM elisp)
'(a . b)
'(a . 2999)
;; list
'(1 2 3 (3 4 ) (5 6 (+ 3 4)) 10 'a 'b "hello")
;; list is not evaluated, even if there is the add function symbol in front
'(+ 1 2 3 4 5)
;; vectors
[1 2 3 4 (+ 1 2 3 45)]

;; basic types predicate
(null nil) ; t, test if argument is nil
(null '()) ; t, note the quoted empty parens
(atom 10) ; t, anything that is not a list or pair is an atom
(atom '(a . b)) ; nil
(atom "hello world") ; t
(atom 'user-login-name)
(bufferp (current-buffer)) ; t, test if a buffer
(bufferp (selected-window)) ; nil
(windowp (selected-window)) ; t
(framep (selected-frame)) ; x

;; get object type
(type-of (current-buffer)) ; buffer
(type-of (selected-window)) ; window
(equal 'buffer (type-of (current-buffer))) ; t
(equal 'buffer (type-of (selected-window))) ; nil

;; constants
(defconst bash-shell "usr/bin/bash")
bash-shell

;; define variables with setq, not set
(setq x 10)
(setq avar "hello there emacs world!")
(setq my-list '(10 20 30 40 50))
;; call the variables
x
my-list
avar ;; error, symbol is void

;; dynamic scoping (local variables)
(let ((x 1) (y 10)) (+ (* 4 x) (* 5 y))) ;; the declared variables are dynamically called/evaluated
x ; 10, ok
y ; error, variable is void, since y is used inside the let definition

;; defining functions
(defun addfunction (a b c)
  (+ a b c))
(addfunction 10 20 30) ; 60 ok
(addfunction 10 "james bond") ; cant add integer with string, lol :-)
(defun myfun ()
  (message "Hello there %s, welcome to Emacs world!" user-login-name))
(myfun) ; ok




(provide 'practice.elisp)
;;; practice.elisp ends here
