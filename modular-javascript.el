;;; modular-javascript.el --- Javascript init

;; Copyright (C) 2015  Alexander Kahl

;; Author: Alexander Kahl <e-user@fsfe.org>
;; Keywords: javascript, js

;;; Code:
;;;###autoload
(add-to-list 'modular-features 'modular-javascript)

(require 'modular-elpa)
(install 'js2-mode)

(require 'js2-mode)
(add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode))
(setq js2-skip-preprocessor-directives t)

(provide 'modular-javascript)
;;; modular-javascript.el ends here
