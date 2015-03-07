;;; modular-projectile.el --- Projectile init

;; Copyright (C) 2014  Alexander Kahl

;; Author: Alexander Kahl <alexander.kahl@hereo.com>
;; Keywords: projectile

;;; Code:
;;;###autoload
(add-to-list 'modular-features 'modular-projectile)

(require 'modular-elpa)
(install 'projectile)
(require 'projectile)

(projectile-global-mode)
(setq projectile-enable-caching nil)

(provide 'modular-projectile)
;;; modular-projectile.el ends here
