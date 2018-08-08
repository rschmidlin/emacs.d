;; Install use-package for managing packages
(add-to-list 'load-path "~/.emacs.d/use-package")
(require 'use-package)
(setq use-package-always-ensure t)

;; Configure proxy servers to be used
(load-file "~/.emacs.d/proxy_conf.el")
;; (require 'package)
;; (add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))

(add-to-list 'load-path "~/.emacs.d/user-defaults")
(load "purcell-adaptation")
(load "operating_system")
(use-package levenshtein)

(defvar golden-vertical-orientation t
  "If orientation should be vertical now")

(defun golden-split-window ()
  (interactive)
  (let* ((nr-of-windows (count-windows))
         (target-window (golden-target-window nr-of-windows))
         (pivot-window (golden-pivot-window nr-of-windows target-window))
         (new-nr-of-windows (1+ nr-of-windows)))
    (other-window pivot-window)
    (if golden-vertical-orientation
        (split-window-right)
      (split-window-below))
    (other-window 1)
    (golden-navigate-to-buffer nr-of-windows)
    (other-window (- new-nr-of-windows pivot-window 1))
    (if (= new-nr-of-windows target-window)
        (setq golden-vertical-orientation (not golden-vertical-orientation)))))

(defun golden-delete-window-after-advice (&optional window-nr)
  (let ((previous-nr-of-windows (1+ (count-windows)))
        (target-window (golden-target-window (count-windows))))
    (if (= previous-nr-of-windows target-window)
        (setq golden-vertical-orientation (not golden-vertical-orientation)))))

(defun golden-delete-other-windows-after-advice (&optional window-nr)
  (setq golden-vertical-orientation t))

(defun golden-pivot-window (window-number target-window)
  "Calculate the window number for next split operation"
  (- target-window window-number 1))

(defun golden-target-window (window-number)
  "Calculates the next target number of windows based on current WINDOW-NUMBER"
  (let ((range '(2 4 8 16 32 64))
        (n 0))
    (while (>= window-number (nth n range))
      (setq n (1+ n)))
    (nth n range)))

(defun golden-navigate-to-buffer (number)
  "Rotates the buffer until we find the one in the list indexed by NUMBER"
  (dotimes (buffer-to-switch number nil)
    (next-buffer)))

(advice-add #'delete-other-windows :after #'golden-delete-other-windows-after-advice)
(advice-add #'delete-window :after #'golden-delete-window-after-advice)

(load "input")
(load "indexers")
(load "lang-c")
(load "window-configuration")
(load "debugger-configuration")

(global-auto-revert-mode t)
(global-disable-mouse-mode)

(provide 'init-local)
