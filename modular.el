;;; modular.el --- Meta-snippet to load .emacs configuration snippets

;; Copyright (C) 2012, 2014  Alexander Kahl

;; Author: Alexander Kahl <e-user@fsfe.org>
;; Keywords: emacs, modular

;;; Code:
;;;###autoload
(defvar modular-features nil)

;;;###autoload
(defcustom load-modular-features nil "Standard modular features to load")

(require 'modular-elpa)
(require 'cl)

(defun modular-load (filter)
  (let ((fs (if filter
                (intersection filter modular-features)
              modular-features)))
    (dolist (f (sort fs #'(lambda (f1 f2) (string< (symbol-name f1) (symbol-name f2)))))
      (message "Loading feature %s..." f)
      (require f))))

(defun modular-update-autoloads ()
  (interactive)
  (let ((generated-autoload-file (concat default-directory "/modular-autoloads.el")))
    (update-directory-autoloads default-directory)))

;;;###autoload
(defun modular ()
  (interactive)
  (modular-load load-modular-features))

(provide 'modular)
;;; modular.el ends here
