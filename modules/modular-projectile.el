;;; modular-projectile.el --- Projectile init

;; Copyright © 2014  Alexander Kahl

;; Author: Alexander Kahl <e-user@fsfe.org>
;; Keywords: projectile

;;; Code:
;;;###autoload
(add-to-list 'modular-features 'modular-projectile)

(install 'projectile)
(require 'projectile)

(projectile-global-mode)
(setq projectile-enable-caching nil)

(provide 'modular-projectile)
;;; modular-projectile.el ends here
