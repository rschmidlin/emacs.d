(setq c-default-style "k&r"
      c-basic-offset 4
      default-tab-width 4
      ident-tabs-mode t)

;; Stop highlighting trailing whitespaces in C
(add-hook 'c-mode-hook 'sanityinc/no-trailing-whitespace)
(add-hook 'c++-mode-hook 'sanityinc/no-trailing-whitespace)

;; Enable CMake major mode
(use-package cmake-mode)

(use-package cmake-font-lock
  :init
  (add-hook 'cmake-mode-hook 'cmake-font-lock-activate))

;; Configure C-style
(when (not (eq system-type 'windows-nt))
  (use-package rtags
    :init
    (use-package ivy-rtags)
    :config
    (setq rtags-display-result-backend 'ivy)))

(when (not (eq system-type 'windows-nt))
  (use-package cmake-ide
    :init
    (require 'rtags)
    :config
    (require 'cmake-ide)
    (cmake-ide-setup)))
