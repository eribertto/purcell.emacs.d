;;; package --- Summary
;;; Commentary:
;;; this is practice file for emacs lisp coding
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

;; from the elisp manual
(progn (prin1 'foo)
       (princ "\n")
       (prin1 'bar))
;; progn is a special form in ‘C source code’.
;; (progn BODY...)
;; Eval BODY forms sequentially and return value of last one.

(emacs-version t)
;; GNU Emacs 30.0.50 (build 1, x86_64-pc-linux-gnu, GTK+ Version 3.24.38, cairo version 1.18.0)
(emacs-build-description)
(current-buffer) ; output is printed in hash notation
;; im reading elisp manual including intro to emacs programming
;; variadic functions aka those with many arguments
(defun mysum (&rest numbers)
  (apply #'+ numbers)) ;; note the function symbol +
;; call it
(mysum 1 2 3 4 5) ; 15
;; using builtin func apply
(apply #'mysum '(1 2 3 5 6 7)) ; 24

;; apply is a built-in function in ‘C source code’.
;; (apply FUNCTION &rest ARGUMENTS)
;; Call FUNCTION with our remaining args, using our last arg as list of args.
;; Then return the value FUNCTION returns.
;; With a single argument, call the argument’s first element using the
;; other elements as args.
;; Thus, (apply '+ 1 2 '(3 4)) returns 10.

(defun sum-prod (a &rest xs)
  "Add A to the sum of arguments XS."
  (* a (apply #'+ xs)))
(sum-prod 3 1 2 3 4 5) ; 45

;; functions with optional arguments
(defun test-optional (a &optional b)
  (list a b))

(test-optional 10 20) ; (10 20)
(setq herbivores '(zebra elephant horse camel spider)
      carnivores '(lion tiger bear wild-dogs shark killer-whales)
      evenumbers '(2 4 6 8 10))
(test-optional evenumbers carnivores)
;; ((2 4 6 8 10) (lion tiger bear wild-dogs shark killer-whales))
(test-optional carnivores)
;; ((lion tiger bear wild-dogs shark killer-whales) nil)

;; another func with optional args
(defun testop2 (a b &optional b c d e)
  (list :a a :b b :c c :d d :e e)) ; note b is part of optional
(testop2 0 1 2 3 4 5) ; second element 1 is not in the output list!!!
;; (:a 0 :b 2 :c 3 :d 4 :e 5)
(testop2 carnivores) ; this is error
;; pp-eval-expression: Wrong number of arguments: (lambda (a b &optional b c d e) (list :a a :b b :c c :d d :e ...)), 1
(testop2 carnivores herbivores)
;; (:a (lion tiger bear wild-dogs shark killer-whales) :b nil :c nil :d
(testop2 carnivores herbivores evenumbers)
;; (:a (lion tiger bear wild-dogs shark killer-whales) :b (2 4 6 8 10) :c
;;     nil :d nil :e nil)

;; now required arg is just 1 and the rest optional
(defun testop3 (a &optional b c d e)
  (list :a a :b b :c c :d d :e e))

(testop3 carnivores herbivores evenumbers)
;; (:a (lion tiger bear wild-dogs shark killer-whales) :b
;;     (zebra elephant horse camel spider) :c (2 4 6 8 10) :d nil :e nil)





(provide 'practice.elisp)
;;; practice.elisp ends here
