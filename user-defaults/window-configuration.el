(use-package tabbar
  :config
  (tabbar-mode))

(use-package golden-ratio
  :config
  (require 'golden-ratio)
  (golden-ratio-mode 1)
  (advice-add #'ace-window :after #'golden-ratio))

(defvar e2wm:active
  "Defines if e2wm has been activated"
  nil)

(defun e2wm:toggle ()
  "Toggles if window management is done by e2wm"
  (interactive)
  (if e2wm:active
      (progn
        (e2wm:stop-management)
        (global-linum-mode)
        (golden-ratio-mode t)
        (advice-add #'ace-window :after #'golden-ratio))
    (progn
      (global-linum-mode -1)
      (golden-ratio-mode -1)
      (advice-remove #'ace-window #'golden-ratio)
      (e2wm:start-management)))
  (setq e2wm:active (not e2wm:active)))

(use-package e2wm
  :config
  (require 'e2wm)
  (global-set-key (kbd "M-+") 'e2wm:toggle))

(set-face-attribute 'default nil :height 140)

(global-linum-mode)
