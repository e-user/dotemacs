;;; modular-irony.el --- Initialize irony            -*- lexical-binding: t; -*-

;; Copyright © 2015  Alexander Kahl

;; Author: Alexander Kahl <ak@sodosopa.io>
;; Keywords: emacs, autocompletion

;;; Code:
;;;###autoload
(add-to-list 'modular-features 'modular-irony)

(require 'modular-company)
(install 'irony 'company-irony)

(add-hook 'c++-mode-hook 'irony-mode)
(add-hook 'c-mode-hook 'irony-mode)
(add-hook 'objc-mode-hook 'irony-mode)

;; replace the `completion-at-point' and `complete-symbol' bindings in
;; irony-mode's buffers by irony-mode's function
(defun my-irony-mode-hook ()
  (define-key irony-mode-map [remap completion-at-point]
    'irony-completion-at-point-async)
  (define-key irony-mode-map [remap complete-symbol]
    'irony-completion-at-point-async))
(add-hook 'irony-mode-hook 'my-irony-mode-hook)
(add-hook 'irony-mode-hook 'irony-cdb-autosetup-compile-options)

(eval-after-load 'company
  '(add-to-list 'company-backends 'company-irony))

(provide 'modular-irony)
;;; modular-irony.el ends here
