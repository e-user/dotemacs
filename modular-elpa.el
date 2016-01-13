;;; modular-elpa.el --- Load and/or install ELPA

;; Copyright (C) 2012, 2014  Alexander Kahl

;; Author: Alexander Kahl <e-user@fsfe.org>
;; Keywords: emacs, modular, elpa

;;; Code:
;;;###autoload
(add-to-list 'modular-features 'modular-elpa)

(unless (require 'package nil t)
  (let ((buffer (url-retrieve-synchronously "http://bit.ly/pkg-el23")))
   (save-excursion
      (set-buffer buffer)
      (goto-char (point-min))
      (re-search-forward "^$" nil 'move)
      (eval-region (point) (point-max))
      (kill-buffer (current-buffer)))))

(package-initialize)
(add-to-list 'package-archives
             '("marmalade" . "http://marmalade-repo.org/packages/"))
(add-to-list 'package-archives
             '("melpa" . "http://melpa.org/packages/"))
(add-to-list 'package-archives
             '("melpa-stable" . "http://stable.melpa.org/packages/"))

(defvar modular-elpa-late-init nil
  "Indicator whether package-refresh-contents has been executed")

(defadvice package-install (before modular-elpa-late-init-advice)
  (unless modular-elpa-late-init
    (setq modular-elpa-late-init t)
    (package-refresh-contents)))

(ad-activate 'package-install)

(defun install (&rest packages)
  (dolist (package packages)
    (when (not (package-installed-p package))
      (package-install package))))

;;;###autoload
(defun pin (repository &rest packages)
  (when (boundp 'package-pinned-packages)
    (setq package-pinned-packages
          (cl-nunion package-pinned-packages
                     (mapcar #'(lambda (x) (cons x repository)) packages)
                     :test #'equal))))

(provide 'modular-elpa)
;;; modular-elpa.el ends here
