;;; package --- Summary
;;; Commentary:
;;; Code:

(defun adjust-frame-size-and-position (&optional frame)
  "Adjust size and position of FRAME based on its type."
  (called-interactively-p;; Happy hacking, eriberttom - Emacs ♥ you!
   )
  (if (display-graphic-p frame)
      (let* ((w 150)              ; Set to desired width in characters
             (h 50)               ; Set to desired height in lines
             (width (* w (frame-char-width frame)))
             (height (* h (frame-char-height frame)))
             (left (max 0 (floor (/ (- (x-display-pixel-width) width) 2))))
             (top (max 0 (floor (/ (- (x-display-pixel-height) height) 2)))))

        (set-frame-size frame w h)
        (set-frame-position frame left top))
    ;; Ensure the menu bar is off in terminal mode
    (when (and (not (display-graphic-p frame))
               (menu-bar-mode 1))
      (menu-bar-mode -1))))
(provide 'adjust-frame-size)
;;; adjust-frame-size.el ends here
