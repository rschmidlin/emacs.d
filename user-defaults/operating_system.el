; Configure Emacs to use find and grep from MSYS
(setenv "PATH"
        (concat
         ;; Change this with your path to MSYS bin directory
         "C:\\MinGW\\msys\\1.0\\bin;"
         "/usr/local/bin:"
         (getenv "PATH")))

;; Install cygwin-mount to work with Cygwin paths
;; (use-package cygwin-mount
;;   :pin melpa
;;   :init
;;   (require 'cygwin-mount))

(setq path-to-ctags "c:/Users/SESA452110/MyPrograms/bin/ctags.exe")

(when (eq system-type 'windows-nt)
  (when (boundp 'w32-pipe-read-delay)
    (setq w32-pipe-read-delay 0))
  ;; Set the buffer size to 64K on Windows (from the original 4K)
  (when (boundp 'w32-pipe-buffer-size)
    (setq irony-server-w32-pipe-buffer-size (* 64 1024))))
