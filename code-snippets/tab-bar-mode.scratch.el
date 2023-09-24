;;; package --- Summary
;;; Commentary:
;; tab bar mode snippets
;; https://mihaiolteanu.me/emacs-workspace-management
;;; TODO print this including the link and study it and implement


;; Ensure the needed tabs are created or exist; add extra to your liking
(progn (tab-create "files")
       (tab-create "eshells")
       (tab-create "exwm"))

(defun tab-create (name)
  "Create the NAME tab if it doesn't exist already."
  (condition-case nil
      (unless (equal (alist-get 'name (tab-bar--current-tab))
                     name)
        (tab-bar-rename-tab-by-name name name))
    (error (tab-new)
           (tab-bar-rename-tab name))))

;; Hide the tabs since I don't want to click on them.
(setf tab-bar-show nil)
        
(defun tab-bar-files ()
  "Select the files tab-bar. Force return `t'."
  (interactive)
  (tab-bar-select-tab-by-name "files")
  t)

(defun tab-bar-eshells ()
  "Select the eshells tab-bar. Force return `t'."
  (interactive)
  (tab-bar-select-tab-by-name "eshells")
  t)

(defun tab-bar-exwm ()
  "Select the wm tab-bar. Force return `t'."
  (interactive)
  (tab-bar-select-tab-by-name "exwm")
  t)

(bind-keys
 ("s-F" . tab-bar-files)
 ("s-W" . tab-bar-exwm)
 ("s-Z" . tab-bar-eshells))


;; I'm advising the function that does the buffer switching. How does advising work? Let's say I have a
;; package defining a function myf,

(defun myf (n)
  (message "The number: %d" 5))

;; Eval and check the *Messages* buffer
(myf 5)
The number: 5
        

(defun myf (n)
  (message "I've called myf with argument %d" n)
  (message "The number: %d" 5))

;; Eval and check the *Messages* buffer
(myf 5)
I’ve called myf with argument 5
The number: 5
        
(defun myf (n)
  (message "The number: %d" 5))

(myf 5)
The number: 5

(advice-add 'myf
  :before (lambda (n)
            (message "I've called myf with argument %d" n)))

(myf 5)
I’ve called myf with argument 5
The number: 5
        
(defun myf (n)
  (message "The number is: %d" 5))

(myf 5)
I’ve called myf with argument 5
The number is: 5
        
(defun ivy-switch-buffer ()
  "Switch to another buffer."
  (interactive)
  (ivy-read "Switch to buffer: " #'internal-complete-buffer
            :keymap ivy-switch-buffer-map
            :preselect (buffer-name (other-buffer (current-buffer)))
            :action #'ivy--switch-buffer-action
            :matcher #'ivy--switch-buffer-matcher
            :caller 'ivy-switch-buffer))
        
;; Make sure `ivy-switch-buffer' opens each buffer in it's correct tab,
;; depending on its mode.
(advice-add 'ivy--switch-buffer-action
            :before #'switch-to-tab-based-on-mode)

(defun switch-to-tab-based-on-mode (buff)
  "Switch to the desired tab-bar, depending on BUFF mode."  
  (or (and (buffer-mode-p buff 'eshell-mode)
           ;; open eshell buffers in the eshells tab
           (tab-bar-eshells))
      (and (buffer-mode-p buff 'exwm-mode)
           ;; ..browsers and the like in the exwm tab
           (tab-bar-exwm))
      ;; ...and the rest of the buffers in the files tab
      (tab-bar-files)))

(defun buffer-mode-p (buffer-or-string mode)
  "Returns the major mode associated with a buffer."
  (with-current-buffer buffer-or-string
    (equal major-mode mode)))
        

(advice-add 'find-file
            :around #'find-file-in-the-files-tab-advice)

(defun find-file-in-the-files-tab-advice (orig-func filename &rest wildcards)
  "Open FILENAME in the files tab."
  (let ((dir default-directory))
    (tab-bar-select-tab-by-name "files")
    (let ((default-directory dir))
      (apply orig-func filename wildcards))))
        
(defhydra hydra-file (:exit t)
  ("w" (lambda () (interactive) (switch-to-buffer "chromium" )) "browser")
  ("s" (lambda () (interactive) (switch-to-buffer "*scratch*")) "*scratch*")
  ("i" (lambda () (interactive) (switch-to-buffer "init.el"  )) "init.el")  
  ("c" (lambda () (interactive) (switch-to-buffer "notes.org")) "notes")
  ("q" nil                                                      "quit"))

(bind-key ("s-f" . hydra-file/body))
        
(defhydra hydra-file (:exit t)
  ("w" (lambda () (interactive) (select-buffer-in-tab "chromium"    "exwm"))  "browser")
  ("s" (lambda () (interactive) (select-buffer-in-tab "*scratch*"   "files")) "*scratch*")
  ("i" (lambda () (interactive) (select-buffer-in-tab "init.el"     "files")) "init.el")
  ("m" (lambda () (interactive) (select-buffer-in-tab "*Messages*"  "files")) "*Messages*")  
  ("c" (lambda () (interactive) (select-buffer-in-tab "cooking.org" "files")) "cooking")
  ("q" nil                                                               "quit"))

(defun select-buffer-in-tab (buffer tab)
  "Select `buffer' in `tab'."
  (tab-bar-select-tab-by-name tab)
  (switch-to-buffer buffer))
        
(defun select-buffer-in-tab (buffer tab)
                "Select or create `buffer' in `tab'."
  (tab-bar-select-tab-by-name tab)
  (if (and (equal tab "exwm")
           (not (get-buffer buffer)))
      (exwm-start-app buffer)
    (switch-to-buffer buffer)))
        
;; Next and previous buffer commands look for the same major mode in case of
;; eshell and exwm buffers.
(bind-keys
 ("C-,"           . previous-buffer-maybe-same-major-mode)
 ("C-."           . next-buffer-maybe-same-major-mode))


(defun next-buffer-maybe-same-major-mode ()
  "Like `next-buffer' for buffers in the current `major-mode'."
  (interactive)
  (change-buffer-maybe-same-major-mode 'next-buffer))

(defun previous-buffer-maybe-same-major-mode ()
  "Like `previous-buffer' for buffers in the current `major-mode'."
  (interactive)
  (change-buffer-maybe-same-major-mode 'previous-buffer))

(defun change-buffer-maybe-same-major-mode (change-buffer)
  "Call CHANGE-BUFFER until the current buffer has the initial `major-mode'.
                Only apply this behavior on selected tabs."
  (let ((tab-name (alist-get 'name (tab-bar--current-tab))))
    (if (member tab-name '("eshells" "exwm"))          
        (let ((mode major-mode)
              (original-buffer (current-buffer)))
          (funcall change-buffer)
          (while (and (not (eq major-mode mode)) (not (eq original-buffer (current-buffer))))
            (funcall change-buffer)))
      (funcall change-buffer))))
        
(advice-add 'ivy--switch-buffer-action
            :before #'switch-to-tab-based-on-mode)

(defun switch-to-tab-based-on-mode (buff)
  "Switch to the desired tab-bar, depending on BUFF mode."
  ;; With universal argument, do nothing, open the the buffer normally.
  (unless current-prefix-arg
    (or (and (buffer-mode-p buff 'eshell-mode)
             ;; Otherwise, open eshell buffers in the eshells tab
             (tab-bar-eshells))
        (and (buffer-mode-p buff 'exwm-mode)
             ;; ..browsers and the like in the exwm tab
             (tab-bar-exwm))
        ;; ...and the rest of the buffers in the files tab
        (tab-bar-files))))
        
("s-e" . open-eshell-in-eshells-tab-here)

(defun open-eshell-in-eshells-tab-here ()  
  (interactive)
  ;;remember the pwd from where we've started, since we're changing tabs and
  ;;buffers and the pwd as a result
  (let ((dir default-directory))    
    (tab-bar-eshells)
    (let ((default-directory dir))
      (eshell 'new-shell))))
        
(defun open-eshell-in-eshells-tab-here ()  
  "Reuse or open a new eshell in the eshells tab and switch to it.
                If there already is an eshell with the same pwd as the file we're
                opening it from, switch to it; otherwise, create a new eshell and
                set it's name accordingly."
  (interactive)
  ;;remember the pwd from where we've started, since we're chainging tabs and
  ;;buffers and the pwd as a result
  (let ((dir default-directory)       
        (existing))
    (tab-bar-eshells)
    (mapcar (lambda (buff)
         (and (equal (buffer-local-value 'default-directory buff)
                     dir)
              (progn (setf existing t)
                     t)                
              (switch-to-buffer buff)))
       (all-buffers-for-major-mode 'eshell-mode))
    (unless existing
      (let ((default-directory dir)
            (eshell-buffer-name (format "*eshell%s" dir)))
        (eshell 'new-shell)))))
        
(add-hook 'eshell-directory-change-hook
  (lambda ()
    (rename-buffer (format "*eshell%s" default-directory) t)))
        
(advice-add 'browse-url
  :before (lambda (url) (tab-bar-exwm)))
        
(bind-keys
 ("C-M-u" . (lambda (interactive) (window-configuration-to-register 'u)))
 ("C-M-i" . (lambda (interactive) (window-configuration-to-register 'i)))
 ("C-M-o" . (lambda (interactive) (window-configuration-to-register 'o)))

 ("M-s-u"  . (lambda (interactive) (jump-to-register 'u)))
 ("M-s-i"  . (lambda (interactive) (jump-to-register 'i)))
 ("M-s-o"  . (lambda (interactive) (jump-to-register 'o))))
