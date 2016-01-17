;;; modular-magit.el --- Initialize magit

;; Copyright © 2015  Alexander Kahl

;; Author: Alexander Kahl <e-user@fsfe.org>
;; Keywords: emacs, magit

;;; Code:
;;;###autoload
(add-to-list 'modular-features 'modular-magit)

;;;###autoload
(pin "melpa-stable" 'magit)

(install 'magit)
(require 'magit)

(setq magit-last-seen-setup-instructions "1.4.0")
(global-set-key (kbd "C-x g") 'magit-status)

(provide 'modular-magit)
;;; modular-magit.el ends here
