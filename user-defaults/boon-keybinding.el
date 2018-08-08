(defvar boon-keybinding-minor-mode-map  (make-sparse-keymap))

;; Use M-SPC to go back to command mode
(define-key boon-keybinding-minor-mode-map (kbd "M-SPC") 'boon-set-command-state)

;; Special help keys like pressing escape for C-g, TAB for searching further
(add-hook 'ivy-mode-hook (lambda () (define-key ivy-minibuffer-map [escape] 'minibuffer-keyboard-quit)))
(define-key isearch-mode-map (kbd "TAB") 'isearch-repeat-forward)

;; Also define commands for C-x that are available from x in Boon
(global-set-key (kbd "C-x o") 'ace-window)
(define-key boon-keybinding-minor-mode-map  (kbd "M-x") 'counsel-M-x)
(define-key boon-command-map (kbd "x x") 'counsel-M-x)
(global-set-key (kbd "C-x x") 'counsel-M-x)

;; Define new commands for command mode
(define-key boon-command-map (kbd ",") 'ace-window)
(define-key boon-command-map (kbd "r") 'swiper)
(define-key boon-command-map (kbd "m") 'golden-split-window)
(define-key boon-command-map (kbd ".") 'delete-other-windows)
(define-key boon-command-map (kbd ":") 'delete-window)
(define-key boon-command-map (kbd "T") 'query-replace)
(define-key boon-command-map (kbd "_") 'undo-tree-redo)
(define-key boon-command-map (kbd "M-_") 'undo-tree-visualize)
(define-key boon-command-map (kbd "M-f") 'browse-kill-ring)
(define-key boon-goto-map (kbd "i") 'counsel-imenu)

;; New keys on C-x or C-c groups avoiding necessity of pressing control
(global-set-key (kbd "C-x t") 'vr/query-replace)
(global-set-key (kbd "C-x ö") 'save-buffer)
(global-set-key (kbd "C-x j") 'find-file)
(global-set-key (kbd "C-x p") 'recenter-top-bottom)
(global-set-key (kbd "C-x c") 'eval-last-sexp)
(global-set-key (kbd "C-x y") 'comment-dwim)
(global-set-key (kbd "C-x w") 'find-alternate-file)
(global-set-key (kbd "C-x i") 'ibuffer)
(define-key boon-keybinding-minor-mode-map (kbd "C-c C-r") 'counsel-ag)

;; Buffer and window control
(defun xah-new-empty-buffer ()
  "Create a new empty buffer.
     New buffer will be named “untitled” or “untitled<2>”,
     “untitled<3>”, etc.

     URL `http://ergoemacs.org/emacs/emacs_new_empty_buffer.html'
     Version 2016-12-27"
  (interactive)
  (let (($buf (generate-new-buffer "untitled")))
    (switch-to-buffer $buf)
    (funcall initial-major-mode)
    (setq buffer-offer-save t)))

(define-key boon-keybinding-minor-mode-map (kbd "C-c C-l") 'make-frame)
(define-key boon-keybinding-minor-mode-map (kbd "C-c C-k") 'delete-frame)
(global-set-key (kbd "C-x l") 'xah-new-empty-buffer)

;; Help menu on J
(defvar boon-help-map)
(define-prefix-command 'boon-help-map)
(set-keymap-parent boon-help-map help-map)
(define-key boon-command-map (kbd "J") boon-help-map)

;; Include extended indexer navigation for Boon
(define-key boon-keybinding-minor-mode-map (kbd "C-c C-z") 'xref-peek-definitions)
(define-key boon-keybinding-minor-mode-map (kbd "C-c C-f") 'projectile-find-file)
(define-key boon-keybinding-minor-mode-map (kbd "C-c C-i") 'cscope-find-functions-calling-this-function)
(define-key boon-keybinding-minor-mode-map (kbd "C-c C-o") 'cscope-find-called-functions)
(define-key boon-keybinding-minor-mode-map (kbd "C-c C-p") 'cscope-find-this-symbol)

;; Python indexing
(defun raul-find-definitions ()
  (interactive)
  (cond
   ((eq major-mode 'python-mode) (anaconda-mode-find-definitions))
   ((eq major-mode 'c++-mode) (if (not (eq system-type 'windows-nt))
                                  (rtags-find-symbol-at-point)
                                (ggtags-find-tag-dwim (ggtags-read-tag 'definition current-prefix-arg))))
   ((eq major-mode 'c-mode) (ggtags-find-tag-dwim (ggtags-read-tag 'definition current-prefix-arg)))
   (t (xref-find-definitions (xref--read-identifier "Find definitions of: ")))))

(defun raul-find-references ()
  (interactive)
  (cond
   ((eq major-mode 'python-mode) (anaconda-mode-find-references))
   ((eq major-mode 'c++-mode) (if (not (eq system-type 'windows-nt))
                                  (rtags-find-references-at-point)
                                (ggtags-find-reference (ggtags-read-tag 'reference current-prefix-arg))))
   ((eq major-mode 'c-mode) (ggtags-find-reference (ggtags-read-tag 'reference current-prefix-arg)))
   (t (xref-find-references (xref--read-identifier "Find references of: ")))))

(defun raul-pop-marker ()
  (interactive)
  (cond
   ((eq major-mode 'python-mode) (xref-pop-marker-stack))
   ((eq major-mode 'c++-mode) (if (not (eq system-type 'windows-nt))
                                  (rtags-location-stack-back)
                                (ggtags-prev-mark)))
   ((eq major-mode 'c-mode) (ggtags-prev-mark))
   (t (xref-pop-marker-stack))))

(define-key boon-command-map (kbd "z") 'raul-find-definitions)
(define-key boon-command-map (kbd "Z") 'raul-find-references)
(define-key boon-command-map (kbd "N") 'raul-pop-marker)

;; Start org-mode
(define-key boon-keybinding-minor-mode-map (kbd "C-c C-w") 'org-capture)

;; Load current file
(defun load-current-file ()
  "Execute file corresponding to current buffer"
  (interactive)
  (load-file (buffer-file-name)))

(defun raul-send-buffer-to-python ()
  "Send complete buffer to Python"
  (interactive)
  (python-shell-send-buffer t))

(define-key emacs-lisp-mode-map (kbd "C-c C-c") 'load-current-file)
(add-hook 'c-mode-hook (lambda () (define-key c-mode-map (kbd "C-c C-c") 'compile)))
(add-hook 'c++-mode-hook (lambda () (define-key c++-mode-map (kbd "C-c C-c") 'compile)))
(add-hook 'python-mode-hook (lambda () (define-key python-mode-map (kbd "C-c C-c") 'raul-send-buffer-to-python)))

(define-minor-mode boon-keybinding-minor-mode
  "A minor mode so that my key settings override annoying major modes."
  :init-value t
  :lighter boon-keybinding " boon-keybinding"
  :keymap boon-keybinding-minor-mode-map)

(provide 'boon-keybinding)
