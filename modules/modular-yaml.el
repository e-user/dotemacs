;;; modular-yaml.el --- Modular yaml mode            -*- lexical-binding: t; -*-

;; Copyright (C) 2017  Alexander Kahl

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

;; Load yaml

;;; Code:
;;;###autoload
(add-to-list 'modular-features 'modular-yaml)

;;;###autoload
(pin "melpa-stable" 'yaml-mode)

(install 'yaml-mode)
(require 'yaml-mode)

(add-hook 'yaml-mode-hook (lambda () (electric-indent-local-mode -1)))
(define-key yaml-mode-map (kbd "RET") 'electric-newline-and-maybe-indent)

(provide 'modular-yaml)
;;; modular-yaml.el ends here
