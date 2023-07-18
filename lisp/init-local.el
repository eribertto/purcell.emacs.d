;;; init-local.el --- configure default locale -*- lexical-binding: t -*-
;;; Commentary: users personal customization file in addition to custom.el
;;; See this link https://github.com/eribertto/purcell.emacs.d#installation
(setq-default truncate-lines t) ; good for tiling window managers
(size-indication-mode 1) ; display file size
(display-time)
(display-battery-mode)
(when (version<= "27.1" emacs-version) ; speed up long lines
  (global-so-long-mode 1))
(desktop-save-mode 1) ; start emacs in prev state
(save-place-mode 1) ; come back to the same point of the last file
(require 'midnight) ; delete buffers at midnight assuming emacs is 24/7
(midnight-mode 1)







(provide 'init-local)
;;; init-locales.el ends here
