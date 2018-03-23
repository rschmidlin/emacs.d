;; Install use-package for managing packages
(add-to-list 'load-path "~/.emacs.d/use-package")
(require 'use-package)

;; Configure proxy servers to be used
(load-file "~/.emacs.d/proxy_conf.el")

;; MELPA to my package-archives
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))


(add-to-list 'load-path "~/.emacs.d/user-defaults")

;; Configure Emacs according to operating system
(load "operating_system")

;; Select input-interface system 
(load "input")

;; Configure indexers - ctags/cscope/ggtags
;;(setq path-to-ctags "c:/Users/SESA452110/MyPrograms/bin/ctags.exe")
(load "indexers")

(setq c-default-style "k&r"
      c-basic-offset 4
      default-tab-width 4
      ident-tabs-mode t)

(add-hook 'c-mode-hook 'sanityinc/no-trailing-whitespace)
(add-hook 'c++-mode-hook 'sanityinc/no-trailing-whitespace)

;; Stop trailing whitespaces in C
(add-hook 'c-mode-hook 'sanityinc/no-trailing-whitespace)
(add-hook 'c++-mode-hook 'sanityinc/no-trailing-whitespace)

;; (use-package tabbar-group)

(use-package tabbar
  :ensure t
  :pin melpa
  :config
  (tabbar-mode))

(use-package cmake-mode
  :ensure t
  :pin melpa)

(use-package cmake-font-lock
  :ensure t
  :pin melpa
  :init
  (add-hook 'cmake-mode-hook 'cmake-font-lock-activate))

(use-package irony
  :ensure t
  :pin melpa
  :config
  (add-hook 'c++-mode-hook 'irony-mode)
  (add-hook 'c-mode-hook 'irony-mode)
  (add-hook 'objc-mode-hook 'irony-mode)
  (add-hook 'irony-mode-hook 'irony-cdb-autosetup-compile-options))

(use-package flycheck-irony
  :ensure t
  :pin melpa
  :config
  (eval-after-load 'flycheck
    '(add-hook 'flycheck-mode-hook #'flycheck-irony-setup)))

(use-package flycheck-pos-tip
  :ensure t
  :pin melpa
  :config
  (flycheck-pos-tip-mode))

(paredit-mode -1)
(projectile-mode -1)

(server-start)

(set-face-attribute 'default nil :height 120)

(provide 'init-local)
