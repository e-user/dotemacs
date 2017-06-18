;;; modular-company.el --- Initialize company-mode

;; Copyright © 2014-2015  Alexander Kahl

;; Author: Alexander Kahl <ak@sodosopa.io>
;; Keywords: emacs, auto-complete, ac, company

;;; Code:
;;;###autoload
(add-to-list 'modular-features 'modular-company)

;;;###autoload
(pin "melpa-stable" 'company)

(install 'company)

(global-company-mode)
(global-set-key (kbd "C-.") 'company-complete)
(setq company-tooltip-flip-when-above t
      company-idle-delay nil
      company-tooltip-align-annotations t)

(provide 'modular-company)
;;; modular-company.el ends here
