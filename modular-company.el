;;; modular-company.el --- Initialize company-mode

;; Copyright (C) 2014  Alexander Kahl

;; Author: Alexander Kahl <e-user@fsfe.org>
;; Keywords: emacs, auto-complete, ac, company

;;; Code:
;;;###autoload
(add-to-list 'modular-features 'modular-company)

(require 'modular-elpa)
(install 'company 'ac-nrepl)

(add-hook 'after-init-hook 'global-company-mode)
(global-set-key (kbd "C-.") 'company-complete)

(provide 'modular-company)
;;; modular-company.el ends here
