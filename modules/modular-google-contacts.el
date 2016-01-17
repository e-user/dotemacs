;;; modular-google-contacts.el --- Google Contacts   -*- lexical-binding: t; -*-

;; Copyright © 2015  Alexander Kahl

;; Author: Alexander Kahl <e-user@fsfe.org>
;; Keywords: mail

;;; Code:
;;;###autoload
(add-to-list 'modular-features 'modular-google-contacts)

(install 'google-contacts)
(require 'google-contacts)

(provide 'modular-google-contacts)
;;; modular-google-contacts.el ends here
