;;; modular-bookmark+.el --- Initialize bookmark+

;; Copyright © 2015  Alexander Kahl

;; Author: Alexander Kahl <e-user@fsfe.org>
;; Keywords: emacs, bookmarks, bookmark+

;;; Code:
;;;###autoload
(add-to-list 'modular-features 'modular-bookmark+)

(install 'bookmark+)
(require 'bookmark+-lit)
(require 'bookmark+)

(setq bmkp-auto-light-when-set 'any-bookmark
      bmkp-light-style-non-autonamed 'lfringe
      bmkp-light-style-autonamed 'lfringe)

(provide 'modular-bookmark+)
;;; modular-bookmark+.el ends here
