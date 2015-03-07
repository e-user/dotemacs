;;; modular-clojure.el --- Clojure init

;; Copyright (C) 2012, 2014  Alexander Kahl

;; Author: Alexander Kahl <e-user@fsfe.org>
;; Keywords: clojure, midje

;;; Code:
;;;###autoload
(add-to-list 'modular-features 'modular-clojure)

(require 'modular-elpa)
(pin "melpa-stable" 'clojure-mode 'typed-clojure-mode)
(install 'clojure-mode 'typed-clojure-mode)

(require 'clojure-mode)
(add-hook 'clojure-mode-hook 'typed-clojure-mode)

(provide 'modular-clojure)
;;; modular-clojure.el ends here
