;;; modular.el --- Meta-snippet to load .emacs configuration snippets

;; Copyright © 2012-2016  Alexander Kahl

;; Author: Alexander Kahl <ak@sodosopa.io>
;; Keywords: convenience

;;; Code:

(defgroup modular nil
  "Modular module loader"
  :group 'convenience)

(defcustom load-modular-features nil
  "Standard modular features to load"
  :group 'modular)

;;;###autoload
(defvar modular-features nil)
(defvar modular-dir (file-name-directory load-file-name))

(add-to-list 'load-path (expand-file-name "modules" modular-dir))

(require 'modular-defaults)
(require 'modular-elpa)

(defun modular-load (filter)
  (let ((fs (if filter
                (intersection filter modular-features)
              modular-features)))
    (dolist (f (sort fs #'(lambda (f1 f2) (string< (symbol-name f1) (symbol-name f2)))))
      (message "Loading feature %s..." f)
      (condition-case e (require f)
        (error (message "Error loading %s: %s" f e))))))

(defun modular-update-autoloads ()
  (interactive)
  (mapc #'(lambda (s)
	    (let* ((dir (expand-file-name s modular-dir))
		   (generated-autoload-file (expand-file-name "modular-autoloads.el" dir)))
	      (update-directory-autoloads dir)))
	'("" "modules")))

(defun modular-extend-path (path)
  (let ((path (expand-file-name path)))
    (add-to-list 'exec-path path)
    (setenv "PATH" (concat path ":" (getenv "PATH")))))

;;;###autoload
(defun modular ()
  (interactive)
  (load (expand-file-name "modules/modular-autoloads.el" modular-dir))
  (modular-load load-modular-features))

(provide 'modular)
;;; modular.el ends here
