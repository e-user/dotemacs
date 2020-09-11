;;; modular-editorconfig.el --- Modular editorconfig module  -*- lexical-binding: t; -*-

;; Copyright (C) 2017  Alexander Dorn

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

;; Load editorconfig

;;; Code:
;;;###autoload
(add-to-list 'modular-features 'modular-editorconfig)

;;;###autoload
(pin "melpa-stable" 'editorconfig)

(install 'editorconfig)
(require 'editorconfig)

(editorconfig-mode 1)

(provide 'modular-editorconfig)
;;; modular-editorconfig.el ends here
