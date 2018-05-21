(use-package tabbar
  :config
  (tabbar-mode))

(use-package golden-ratio
  :config
  (require 'golden-ratio)
  (golden-ratio-mode 1)
  (advice-add #'ace-window :after #'golden-ratio))

(use-package e2wm
  :config
  (require 'e2wm)
  (global-set-key (kbd "M-+") 'e2wm:start-management))

(set-face-attribute 'default nil :height 140)

(global-linum-mode)
