;;; frame-change-color-theme.el --- change color of frame
;;; Commentary:
;;; Code:
;; Tuesday 2023-09-19
;; NOTE: the above function doesnt work yet FIXME

(defun vz/apply-theme-in-frame (frame theme)
  "Change color THEME of FRAME, sort of."
  (interactive)
  (pcase-dolist (`(,type ,face _ ,val) (get theme 'theme-settings))
    (let (face-attr)
      (when (and (eq type 'theme-face)
	         (not (eq 0 (setq face-attr (face-spec-choose val frame 0)))))
        (face-spec-set-2 face frame face-attr)))))

;; For this to work, you need to ensure that THEME is already loaded using load-theme.
;; You can change the theme of the current frame to modus-vivendi by doing

(vz/apply-theme-in-frame (selected-frame) 'color-theme-sanityinc-tomorrow-night)

;; TODO: plan to install this theme by Prot
;; modus-themes                   20230918.514  available    melpa    Elegant, highly legible theme set


;;; code body

(provide 'frame-change-color-theme)
;;; frame-change-color-theme.el ends here
