;;; modular-bm.el --- Initialize bm

;; Copyright © 2014  Alexander Kahl

;; Author: Alexander Kahl <e-user@fsfe.org>
;; Keywords: emacs, bm, bookmarks

;;; Code:
;;;###autoload
(add-to-list 'modular-features 'modular-bm)

(install 'bm)
(require 'bm)

(global-set-key (kbd "<C-tab>") 'bm-toggle)
(global-set-key [(control \`)] 'bm-next)
(eval-after-load "org"
  '(define-key org-mode-map (kbd "<C-tab>") nil))

(provide 'modular-bm)
;;; modular-bm.el ends here
