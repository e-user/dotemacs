;;; modular-magit.el --- Initialize magit

;; Copyright © 2015  Alexander Kahl

;; Author: Alexander Kahl <ak@sodosopa.io>
;; Keywords: emacs, magit

;;; Code:
;;;###autoload
(add-to-list 'modular-features 'modular-magit)

;;;###autoload
(pin "melpa-stable" 'magit)

(install 'magit 'magithub)
(require 'magit)
(require 'magithub)

(magithub-feature-autoinject t)

(setq magit-last-seen-setup-instructions "1.4.0"
      magithub-clone-default-directory "~/Projects"
      magit-commit-arguments '("--gpg-sign=33CBBEFEA62ADDE0"))

(global-set-key (kbd "C-x g") 'magit-status)

(provide 'modular-magit)
;;; modular-magit.el ends here
