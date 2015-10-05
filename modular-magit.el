;;; modular-magit.el --- Initialize magit

;; Copyright (C) 2015  Alexander Kahl

;; Author: Alexander Kahl <e-user@fsfe.org>
;; Keywords: emacs, magit

;;; Code:
;;;###autoload
(add-to-list 'modular-features 'modular-magit)

(require 'modular-elpa)
(pin "melpa-stable" 'magit)

(install 'magit)
(require 'magit)

(setq magit-last-seen-setup-instructions "1.4.0")
(global-set-key (kbd "<f1>") 'magit-status)

(provide 'modular-magit)
;;; modular-magit.el ends here
