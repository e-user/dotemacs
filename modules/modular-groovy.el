;;; modular-groovy.el --- Modular groovy module      -*- lexical-binding: t; -*-

;; Copyright (C) 2017  Alexander Dorn

;; Author: Alexander Dorn <alexander.kahl@oliverwyman.com>
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

;; Load Groovy mode

;;; Code:
;;;###autoload
(add-to-list 'modular-features 'modular-groovy)

;;;###autoload
(pin "melpa-stable" 'groovy-mode)

(install 'groovy-mode)
(require 'groovy-mode)

(add-to-list 'auto-mode-alist '("Jenkinsfile\\'" . groovy-mode))
(setq groovy-indent-offset 2)

(provide 'modular-groovy)
;;; modular-groovy.el ends here
