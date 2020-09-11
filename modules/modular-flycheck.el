;;; modular-flycheck.el --- Modular Flycheck module  -*- lexical-binding: t; -*-

;; Copyright (C) 2016  Alexander Dorn

;; Author: Alexander Dorn <ad@sodosopa.io>
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

;; Load Flycheck

;;; Code:
;;;###autoload
(add-to-list 'modular-features 'modular-flycheck)

;;;###autoload
(pin "melpa-stable" 'flycheck-package)

(install 'flycheck 'flycheck-package)
(require 'flycheck)

;(setq flycheck-display-errors-function #'flycheck-pos-tip-error-messages)
(setq flycheck-display-errors-function #'flycheck-display-error-messages-unless-error-list)
(global-flycheck-mode)

(global-set-key (kbd "C-S-b") 'flycheck-previous-error)
(global-set-key (kbd "C-S-f") 'flycheck-next-error)

(provide 'modular-flycheck)
;;; modular-flycheck.el ends here
