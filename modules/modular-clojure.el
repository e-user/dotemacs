;;; modular-clojure.el --- Modular Clojure module	-*- lexical-binding: t; -*-

;; Copyright © 2012-2016  Alexander Kahl

;; Author: Alexander Kahl <e-user@fsfe.org>
;; Keywords: convenience

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.

;;; Commentary:

;; Load Clojure

;;; Code:
;;;###autoload
(add-to-list 'modular-features 'modular-clojure)

;;;###autoload
(pin "melpa-stable" 'clojure-mode 'typed-clojure-mode 'clj-refactor 'clojure-mode-extra-font-locking)

(install 'clojure-mode 'typed-clojure-mode 'clj-refactor 'clojure-mode-extra-font-locking 'flycheck-clojure)

(require 'clojure-mode)
(add-hook 'clojure-mode-hook 'typed-clojure-mode)

(require 'clojure-mode-extra-font-locking)

; (require 'clj-refactor)
; (add-hook 'clojure-mode-hook 'clj-refactor-mode)
; (add-hook 'clojure-mode-hook #'(lambda () (cljr-add-keybindings-with-prefix "C-c C-m")))

;; (eval-after-load 'flycheck
;;   '(progn
;;      (flycheck-clojure-setup)
;;      (defun cider-flycheck-eval (input callback)
;;        "Send the request INPUT and register the CALLBACK as the response handler.
;; Uses the tooling session, with no specified namespace."
;;        (nrepl-request:eval input callback (cider-current-connection) (nrepl-current-tooling-session)))))

(setq clojure-indent-style :always-indent)

(provide 'modular-clojure)
;;; modular-clojure.el ends here
