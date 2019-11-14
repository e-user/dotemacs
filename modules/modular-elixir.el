;;; modular-elixir.el --- Modular Elixir module      -*- lexical-binding: t; -*-

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

;; Load Elixir support

;;; Code:
;;;###autoload
(add-to-list 'modular-features 'modular-elixir)

;;;###autoload
(pin "melpa-stable" 'elixir-mode)

(require 'modular-lsp)
(require 'modular-smartparens)
(require 'modular-dap)
(require 'dap-elixir)

(install 'elixir-mode)

(require 'elixir-mode)
(add-hook 'elixir-mode-hook #'smartparens-strict-mode)
(add-hook 'elixir-mode-hook #'lsp)

(add-hook 'elixir-mode-hook
          #'(lambda () (add-hook 'before-save-hook 'elixir-format nil t)))

(add-to-list 'exec-path (expand-file-name "~/Projects/elixir-ls/release"))

(provide 'modular-elixir)
;;; modular-elixir.el ends here
