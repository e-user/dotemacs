;;; modular-cider.el --- Modular Cider module  -*- lexical-binding: t; -*-

;; Copyright © 2014-2018  Alexander Kahl

;; Author: Alexander Kahl <ak@sodosopa.io>
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
(require 'modular-fira)

(install 'cider 'ac-cider)

(require 'cider)

(add-hook 'cider-interaction-mode-hook 'eldoc-mode)
(add-hook 'cider-mode-hook 'eldoc-mode)
(add-hook 'cider-repl-mode-hook #'fira-code-mode)
(add-hook 'cider-interaction-mode-hook #'fira-code-mode)

;(define-key cider-mode-map (kbd "<C-j>") 'nrepl-newline-and-indent)
;(define-key cider-repl-mode-map (kbd "<C-j>") 'nrepl-newline-and-indent)
;(define-key cider-repl-mode-map (kbd "C-c M-n") 'cider-repl-set-ns)
(setq cider-repl-tab-command 'indent-for-tab-command
      cider-repl-history-file (expand-file-name "~/.cider-history")
      cider-prompt-for-symbol nil
      cider-auto-test-mode 1
      cider-test-show-report-on-success t
      cider-repl-display-help-banner nil
      cider-lein-command "~/bin/lein"
      cider-repl-use-pretty-printing t
      cider-clojure-cli-command "toolbox"
      cider-clojure-cli-global-options "run --container jdk clojure"
      cider-jack-in-default 'clojure-cli
      cider-clojure-cli-parameters "-A:dev -m nrepl.cmdline --middleware '%s'")

(define-key cider-mode-map (kbd "C-.") 'completion-at-point)
(define-key cider-repl-mode-map (kbd "C-.") 'completion-at-point)

(provide 'modular-cider)
;;; modular-cider.el ends here
