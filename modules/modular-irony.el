;;; modular-irony.el --- Initialize irony            -*- lexical-binding: t; -*-

;; Copyright © 2015, 2018  Alexander Dorn

;; Author: Alexander Dorn <ad@sodosopa.io>
;; Keywords: emacs, autocompletion

;;; Code:
;;;###autoload
(add-to-list 'modular-features 'modular-irony)

(require 'modular-company)
(install 'irony 'company-irony)

(require 'irony)
(require 'company-irony)

(defun my-irony-mode-on ()
  ;; avoid enabling irony-mode in modes that inherits c-mode, e.g: php-mode
  (when (member major-mode irony-supported-major-modes)
    (irony-mode 1)))

(add-hook 'c++-mode-hook 'my-irony-mode-on)
(add-hook 'c-mode-hook 'my-irony-mode-on)
(add-hook 'objc-mode-hook 'my-irony-mode-on)

;; replace the `completion-at-point' and `complete-symbol' bindings in
;; irony-mode's buffers by irony-mode's function
(defun my-irony-mode-hook ()
  (define-key irony-mode-map [remap completion-at-point]
    'irony-completion-at-point-async)
  (define-key irony-mode-map [remap complete-symbol]
    'irony-completion-at-point-async))
(add-hook 'irony-mode-hook 'my-irony-mode-hook)
(add-hook 'irony-mode-hook 'irony-cdb-autosetup-compile-options)

(add-to-list 'company-backends 'company-irony)

(provide 'modular-irony)
;;; modular-irony.el ends here
