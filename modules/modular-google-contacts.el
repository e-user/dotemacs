;;; modular-google-contacts.el --- Google Contacts   -*- lexical-binding: t; -*-

;; Copyright © 2015  Alexander Kahl

;; Author: Alexander Kahl <e-user@fsfe.org>
;; Keywords: mail

;;; Code:
;;;###autoload
(add-to-list 'modular-features 'modular-google-contacts)

(install 'google-contacts)
(require 'google-contacts)

;; (require 'cl-lib)

;; (defvar foo nil)
;; (defun google-contacts-query (query-string)
;;   (google-contacts-async-api query-string #'(lambda (contacts) (setq foo contacts))))

;; (defun company-google-contacts-backend (command &optional arg &rest ignored)
;;   (interactive (list 'interactive))
;;   (cl-case command
;;     (interactive (company-begin-backend 'company-google-contacts-backend))
;;     (prefix (company-grab-symbol))))

(provide 'modular-google-contacts)
;;; modular-google-contacts.el ends here
