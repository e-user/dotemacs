;;; modular-password-store.el --- password-store init

;; Copyright © 2015  Alexander Kahl

;; Author: Alexander Kahl <e-user@fsfe.org>
;; Keywords: password-store, passwords

;;; Code:
;;;###autoload
(add-to-list 'modular-features 'modular-password-store)

(install 'password-store)
(require 'password-store)

(provide 'modular-password-store)
;;; modular-password-store.el ends here
