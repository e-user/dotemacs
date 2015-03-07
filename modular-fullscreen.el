;;; modular-fullscreen.el --- Fullscreen support

;; Copyright (C) 2014  Alexander Kahl

;; Author: Alexander Kahl <e-user@fsfe.org>
;; Keywords: fullscreen

;;; Code:
;;;###autoload
(add-to-list 'modular-features 'modular-fullscreen)

(defun switch-full-screen ()
  (interactive)
  (shell-command "wmctrl -r :ACTIVE: -btoggle,fullscreen"))

(global-set-key [f11] 'switch-full-screen)

(setq initial-frame-alist '((fullscreen . maximized)))

(provide 'modular-fullscreen)
;;; modular-fullscreen.el ends here
