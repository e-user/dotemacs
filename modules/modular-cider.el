;;; modular-cider.el --- Modular Cider module  -*- lexical-binding: t; -*-

;; Copyright © 2014-2016  Alexander Kahl

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

;; Load Cider

;;; Code:
;;;###autoload
(add-to-list 'modular-features 'modular-cider)

;;;###autoload
(pin "melpa-stable" 'cider 'ac-cider)

(require 'modular-clojure)
(require 'modular-company)

(install 'cider 'ac-cider 'cider-eval-sexp-fu)

(require 'cider)
(require 'cider-eval-sexp-fu)

(add-hook 'cider-interaction-mode-hook 'eldoc-mode)
(add-hook 'cider-mode-hook 'eldoc-mode)

;(define-key cider-mode-map (kbd "<C-j>") 'nrepl-newline-and-indent)
;(define-key cider-repl-mode-map (kbd "<C-j>") 'nrepl-newline-and-indent)
;(define-key cider-repl-mode-map (kbd "C-c M-n") 'cider-repl-set-ns)
(setq cider-repl-tab-command 'indent-for-tab-command
      cider-repl-history-file (expand-file-name "~/.cider-history")
      cider-prompt-for-symbol nil)

(define-key cider-mode-map (kbd "C-.") 'completion-at-point)
(define-key cider-repl-mode-map (kbd "C-.") 'completion-at-point)

(provide 'modular-cider)
;;; modular-cider.el ends here
