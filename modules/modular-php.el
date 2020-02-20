;;; modular-php.el --- Modular PHP module            -*- lexical-binding: t; -*-

;; Copyright (C) 2019  Alexander Dorn

;; Author: Alexander Dorn <a.kahl@planetary-networks.de>
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
;; along with this program.  If not, see <https://www.gnu.org/licenses/>.

;;; Commentary:

;; Load modular support

;;; Code:
;;;###autoload
(add-to-list 'modular-features 'modular-php)

;;;###autoload
(pin "melpa-stable" 'php-mode 'flymake-php 'company-php)

(install 'php-mode 'flymake-php 'company-php)

(require 'modular-company)
(add-hook 'php-mode-hook
          #'(lambda () (add-to-list 'company-backends 'company-ac-php-backend )))

(provide 'modular-php)
;;; modular-php.el ends here
