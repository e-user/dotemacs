;;; modular-magit.el --- Initialize magit

;; Copyright (C) 2015  Alexander Kahl

;; Author: Alexander Kahl <e-user@fsfe.org>
;; Keywords: emacs, magit

;;; Code:
;;;###autoload
(add-to-list 'modular-features 'modular-magit)

(require 'modular-elpa)
(install 'magit)
(require 'magit)

(global-set-key (kbd "<f1>") 'magit-status)

(provide 'modular-magit)
;;; modular-magit.el ends here
