;;; modular-theme.el --- theme init

;; Copyright (C) 2014  Alexander Kahl

;; Author: Alexander Kahl <e-user@fsfe.org>
;; Keywords: emacs, color, theme

;;; Code:
;;;###autoload
(add-to-list 'modular-features 'modular-theme)

(require 'modular-elpa)

(install 'cyberpunk-theme)
(load-theme 'cyberpunk t)

(provide 'modular-theme)
;;; modular-theme.el ends here
