;;; modular-dired.el --- Dired init

;; Copyright (C) 2014  Alexander Kahl

;; Author: Alexander Kahl <e-user@fsfe.org>
;; Keywords: dired

;;; Code:
;;;###autoload
(add-to-list 'modular-features 'modular-dired)

(require 'dired)
(put 'dired-find-alternate-file 'disabled nil)
(define-key dired-mode-map (kbd "RET") 'dired-find-alternate-file)
(define-key dired-mode-map (kbd "<backspace>") 'dired-up-directory)

(when (file-accessible-directory-p "~/.emacs.d/dired-launch")
  (load (expand-file-name "~/.emacs.d/dired-launch/dired-launch.el")))

(require 'dired-extension nil t)

(define-key dired-mode-map "\M-o" nil)

(provide 'modular-dired)
;;; modular-dired.el ends here
