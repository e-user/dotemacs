;;; modular-w3m.el --- Initialize w3m

;; Copyright © 2015  Alexander Dorn

;; Author: Alexander Dorn <ad@sodosopa.io>
;; Keywords: w3m, www, browsing, web

;;; Code:
;;;###autoload
(add-to-list 'modular-features 'modular-w3m)

(install 'w3m)

(when (and (executable-find "w3m")
	   (require 'w3m))
  (setq w3m-home-page "about:blank"
	w3m-use-cookies t)

  (mapc #'(lambda (key) (define-key w3m-mode-map (kbd key) nil))
	'("<down>" "<up>" "<left>" "<right>")))

(provide 'modular-w3m)
;;; modular-w3m.el ends here
