;;; modular-eclim.el --- theme init

;; Copyright (C) 2015  Alexander Kahl

;; Author: Alexander Kahl <e-user@fsfe.org>
;; Keywords: emacs, java, eclipse, eclim

;;; Code:
;;;###autoload
(add-to-list 'modular-features 'modular-eclim)

(require 'modular-elpa)
(require 'modular-company)

(install 'emacs-eclim)
(require 'eclimd)

(setq eclimd-default-workspace (expand-file-name "~/Projects/eclipse"))
(global-eclim-mode)
(require 'company-emacs-eclim)
(company-emacs-eclim-setup)

(provide 'modular-eclim)
;;; modular-eclim.el ends here
