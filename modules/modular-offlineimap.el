;;; modular-offlineimap.el --- Offlineimap init

;; Copyright © 2014, 2015  Alexander Kahl

;; Author: Alexander Kahl <ak@sodosopa.io>
;; Keywords: offlineimap

;;; Code:
;;;###autoload
(add-to-list 'modular-features 'modular-offlineimap)

(install 'offlineimap)
(require 'offlineimap)

(setq offlineimap-enable-mode-line-p nil
      offlineimap-command "journalctl -o cat -f --user-unit=offlineimap")

(offlineimap)

(provide 'modular-offlineimap)
;;; modular-offlineimap.el ends here
