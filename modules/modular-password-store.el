;;; modular-password-store.el --- password-store init

;; Copyright © 2015, 2018  Alexander Kahl

;; Author: Alexander Kahl <ak@sodosopa.io>
;; Keywords: password-store, passwords

;;; Code:
;;;###autoload
(add-to-list 'modular-features 'modular-password-store)

(require 'modular-helm)

(install 'password-store 'helm-pass)
(require 'password-store)
(require 'helm-pass)

(provide 'modular-password-store)
;;; modular-password-store.el ends here
