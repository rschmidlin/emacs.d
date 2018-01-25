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

;; Stop trailing whitespaces in C
(add-hook 'c-mode-hook 'sanityinc/no-trailing-whitespace)
(add-hook 'c++-mode-hook 'sanityinc/no-trailing-whitespace)

(provide 'init-local)
