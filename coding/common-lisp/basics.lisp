;; Happy hacking, eriberttom - Emacs ♥ you!
;; begin common lisp practice coding
;; 2024-04-27

(setf names '((John P Wick) (Malcolm X) (Admiral Grace Murray Hopper) (Spot) (Aristotle) (A A Milne) (Z Z Top) (Sir Larry Olivier) (Miss Scarlett)) );  => ((JOHN P WICK) (MALCOLM X) (ADMIRAL GRACE MURRAY HOPPER) (SPOT) (ARISTOTLE)
                                        ; (A A MILNE) (Z Z TOP) (SIR LARRY OLIVIER) (MISS SCARLETT))


(first names) ; => (JOHN P WICK)
(last names) ; => ((MISS SCARLETT))

;; create a function V1
(defun first-name (name)
  "Select the first name from a name of type list."
  (first name)) ; => FIRST-NAME

(first-name names) ; => (JOHN P WICK) ;; note the return value is a list, not a symbol!
;; to get the return value of first name as a symbol, do this
(first-name (first names)) ; => JOHN

;; create a last-name function
(defun last-name (name)
  "Select the last name from the argument name of type list."
  (first (last name))) ; => LAST-NAME

(last-name names) ; => (MISS SCARLETT) ; a list
(first-name (last-name names)) ; => MISS ; a symbol
(first-name '(eriberto)) ; => ERIBERTO
(last-name '(eriberto)) ; => ERIBERTO

;; using mapcar
;; (mapcar FUNCTION SEQUENCE)
;; Apply FUNCTION to each element of SEQUENCE, and make a list of the results.
;; The result is a list just as long as SEQUENCE.
;; SEQUENCE may be a list, a vector, a bool-vector, or a string.
(mapcar #'last-name names) ; => (WICK X HOPPER SPOT ARISTOTLE MILNE TOP OLIVIER SCARLETT)
(mapcar #'- '(1 2 3 4 5)) ; => (-1 -2 -3 -4 -5)
(mapcar #'+ '(1 2 3 4 5) '(10 20 30 40 50)) ; => (11 22 33 44 55)
(mapcar #'first-name names) ; => (JOHN MALCOLM ADMIRAL SPOT ARISTOTLE A Z SIR MISS)
;; introducing defparameter
(defparameter *titles*
  '(Mr Mrs Miss Ms Sir Madam Dr Admiral Major General)
  "A list of titles that can appear at the start of a name.") ; => *TITLES*

;; so the order of doc string matters for the above defparameter.
;; this is not the same as defun where docstring follows after the function declaration.
