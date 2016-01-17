;;; modular-rotate.el --- Rotate init

;; Copyright © 2014  Alexander Kahl

;; Author: Alexander Kahl <e-user@fsfe.org>
;; Keywords: rotate

;;; Code:
;;;###autoload
(add-to-list 'modular-features 'modular-rotate)

(install 'rotate)

(global-set-key (kbd "<backtab>") 'rotate-window)

(provide 'modular-rotate)
;;; modular-rotate.el ends here
