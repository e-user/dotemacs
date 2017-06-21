;;; modular-projectile.el --- Projectile init

;; Copyright © 2014  Alexander Kahl

;; Author: Alexander Kahl <ak@sodosopa.io>
;; Keywords: projectile

;;; Code:
;;;###autoload
(add-to-list 'modular-features 'modular-projectile)

;;;###autoload
(pin "melpa-stable" 'projectile 'ag)

(install 'projectile 'ag)
(require 'projectile)

(projectile-global-mode)
(setq projectile-enable-caching nil)

(provide 'modular-projectile)
;;; modular-projectile.el ends here
