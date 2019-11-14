;;; modular-lsp.el --- Modular Lsp module      -*- lexical-binding: t; -*-

;; Copyright (C) 2019  Alexander Kahl

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
;; along with this program.  If not, see <https://www.gnu.org/licenses/>.

;;; Commentary:

;; Load Lsp support

;;; Code:
;;;###autoload
(add-to-list 'modular-features 'modular-lsp)

;;;###autoload
(pin "melpa-stable" 'lsp-mode 'company-lsp 'helm-lsp 'lsp-ui)

(install 'lsp-mode 'company-lsp 'helm-lsp 'lsp-ui)
(add-hook 'lsp-mode-hook 'lsp-ui-mode)

(require 'lsp-mode)
(require 'company-lsp)
(push 'company-lsp company-backends)

(provide 'modular-lsp)
;;; modular-lsp.el ends here
