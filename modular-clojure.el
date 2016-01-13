;;; modular-clojure.el --- Clojure init

;; Copyright (C) 2012, 2014, 2015  Alexander Kahl

;; Author: Alexander Kahl <e-user@fsfe.org>
;; Keywords: clojure, midje

;;; Code:
;;;###autoload
(add-to-list 'modular-features 'modular-clojure)

;;;###autoload
(pin "melpa-stable" 'clojure-mode 'typed-clojure-mode 'clj-refactor 'clojure-mode-extra-font-locking)

(require 'modular-elpa)
(install 'clojure-mode 'typed-clojure-mode 'clj-refactor 'clojure-mode-extra-font-locking)

(require 'clojure-mode)
(add-hook 'clojure-mode-hook 'typed-clojure-mode)

(require 'clojure-mode-extra-font-locking)

(require 'clj-refactor)
(add-hook 'clojure-mode-hook 'clj-refactor-mode)
(add-hook 'clojure-mode-hook #'(lambda () (cljr-add-keybindings-with-prefix "C-c C-m")))

(provide 'modular-clojure)
;;; modular-clojure.el ends here
