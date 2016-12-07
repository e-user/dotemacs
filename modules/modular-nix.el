;;; modular-nix.el --- Modular NixOS support         -*- lexical-binding: t; -*-

;; Copyright (C) 2016  Alexander Kahl

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

;; Load NixOS

;;; Code:
;;;###autoload
(add-to-list 'modular-features 'modular-nix)

;;;###autoload
(pin "melpa-stable" 'company-nixos-options 'helm-nixos-options 'nix-buffer 'nix-mode 'nixos-options)

(install 'company-nixos-options 'helm-nixos-options 'nix-buffer 'nix-mode 'nixos-options)

(provide 'modular-nix)
;;; modular-nix.el ends here
