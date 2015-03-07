;;; modular-emacs.el --- Emacs basic init

;; Copyright (C) 2012, 2014  Alexander Kahl

;; Author: Alexander Kahl <e-user@fsfe.org>
;; Keywords: emacs, modular

;;; Code:
;;;###autoload
(add-to-list 'modular-features 'modular-emacs)

(set-language-environment "utf-8")
(prefer-coding-system 'utf-8-unix)
(show-paren-mode)
(transient-mark-mode)
(setq make-backup-files nil)

(provide 'modular-emacs)
;;; modular-emacs.el ends here
