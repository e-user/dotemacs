;;; modular-fonts.el --- Modular font module         -*- lexical-binding: t; -*-

;; Copyright (C) 2018  Alexander Kahl

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

;; Load font support

;;; Code:
;;;###autoload
(add-to-list 'modular-features 'modular-fonts)

(require 'modular-contextual)

(defcontext font-profiles)

(contextual-add-profile "small" (font-profiles) ((default-frame-alist '((font . "Inconsolata-6"))))
  (set-frame-font "Inconsolata-6"))
(contextual-add-profile "normal" (font-profiles) ((default-frame-alist '((font . "Inconsolata-9"))))
  (set-frame-font "Inconsolata-9"))
(contextual-add-profile "large" (font-profiles) ((default-frame-alist '((font . "Inconsolata-12"))))
  (set-frame-font "Inconsolata-12"))
(contextual-add-profile "x-large" (font-profiles) ((default-frame-alist '((font . "Inconsolata-14"))))
  (set-frame-font "Inconsolata-14"))

(contextual-define-context-loader font-profile-loader
  font-profiles (kbd "f"))

(install 'uuidgen)
(require 'uuidgen)

;; (uuidgen nil)
(defconst uuidgen-ns-xrandr "1f5e2260-7b55-49df-9d5b-0e180939d033")

(defun run-xrandr ()
  "Run `xrandr' and return its trimmed output."
  (string-trim (shell-command-to-string "xrandr --listactivemonitors")))

(defun xrandr-uuid ()
  "Generate UUIDv5 for xrandr output."
  (uuidgen-5 uuidgen-ns-xrandr (run-xrandr)))

(defvar screen-configurations
  '(("8a140272-fac2-52bd-9b54-5d05c6f6b860" . zion+uhd)))

(defun activate-font-profile ()
  (contextual-activate-profile 'font-profiles
    (case (alist-get (xrandr-uuid) screen-configurations nil nil #'string-equal)
      (zion+uid "normal")
      (t "normal"))))

(add-hook 'after-make-frame-functions #'(lambda (&rest frame) (activate-font-profile)) t)

(provide 'modular-fonts)
;;; modular-fonts.el ends here
