;; Install use-package for managing packages
(add-to-list 'load-path "~/.emacs.d/use-package")
(require 'use-package)
(setq use-package-always-ensure t)

;; Configure proxy servers to be used
(load-file "~/.emacs.d/proxy_conf.el")

(add-to-list 'load-path "~/.emacs.d/user-defaults")
(load "purcell-adaptation")
(load "operating_system")
(load "input")
(load "indexers")
(load "lang-c")
(load "window-configuration")
(load "debugger-configuration")

(provide 'init-local)
