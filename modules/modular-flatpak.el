;;; modular-flatpak.el --- Modular Flatpak module    -*- lexical-binding: t; -*-

;; Copyright (C) 2019  Alexander Dorn

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
;; along with this program.  If not, see <https://www.gnu.org/licenses/>.

;;; Commentary:

;; Load Flatpak support

;;; Code:
;;;###autoload
(add-to-list 'modular-features 'modular-flatpak)

(setenv "PATH" (concat "/var/run/host/usr/bin" ":" (getenv "PATH")))

(provide 'modular-flatpak)
;;; modular-flatpak.el ends here
