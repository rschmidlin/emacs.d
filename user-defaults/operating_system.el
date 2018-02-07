; Configure Emacs to use find and grep from MSYS
(setenv "PATH"
	(concat
	 ;; Change this with your path to MSYS bin directory
	 "C:\\MinGW\\msys\\1.0\\bin;"
	 "/usr/local/bin:"
	 (getenv "PATH")))

;; Install cygwin-mount to work with Cygwin paths
(use-package cygwin-mount
  :ensure t
  :pin melpa
  :init
  (require 'cygwin-mount))

(setq path-to-ctags "c:/Users/SESA452110/MyPrograms/bin/ctags.exe")
