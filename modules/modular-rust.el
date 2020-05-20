;;; modular-rust.el --- Modular Rust module          -*- lexical-binding: t; -*-

;; Copyright (C) 2016-2017  Alexander Kahl

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

;; Load Rust and Racer

;;; Code:
;;;###autoload
(add-to-list 'modular-features 'modular-rust)

;;;###autoload
(pin "melpa-stable" 'rust-mode 'racer 'flycheck-rust)

(install 'rust-mode 'racer 'flycheck-rust)

(require 'rust-mode)
(require 'racer)

(require 'modular-company)
(require 'modular-flycheck)
(require 'modular-fira)

(add-hook 'rust-mode-hook #'fira-code-mode)
(add-hook 'rust-mode-hook #'racer-mode)
(add-hook 'racer-mode-hook #'eldoc-mode)
(add-hook 'racer-mode-hook #'company-mode)
(add-hook 'flycheck-mode-hook #'flycheck-rust-setup)

(setq racer-rust-src-path "~/.rustup/toolchains/nightly-x86_64-unknown-linux-gnu/lib/rustlib/src/rust/src"
      rust-cargo-bin (expand-file-name "~/bin/flatpak-cargo")
      flycheck-rust-cargo-executable (expand-file-name "~/bin/flatpak-cargo")
      rust-format-on-save t)

(modular-extend-path "~/.rustup/toolchains/nightly-x86_64-unknown-linux-gnu/bin")

(define-key racer-mode-map (kbd "C-c C-d") #'racer-describe)

(provide 'modular-rust)
;;; modular-rust.el ends here
