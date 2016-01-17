;;; modular-rainbow.el --- Modular Rainbow Delimiters module  -*- lexical-binding: t; -*-

;; Copyright (C) 2016  Alexander Kahl

;; Author: Alexander Kahl <alex@lshift.de>
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

;; Load Rainbow delimiters

;;; Code:
;;;###autoload
(add-to-list 'modular-features 'modular-rainbow)

(install 'rainbow-delimiters)
(require 'rainbow-delimiters)

(add-hook 'emacs-lisp-mode-hook #'rainbow-delimiters-mode)

(eval-after-load 'rainbow-delimiters
  '(progn
     (add-hook 'cider-repl-mode-hook #'rainbow-delimiters-mode)
     (add-hook 'cider-interaction-mode-hook #'rainbow-delimiters-mode)))

(provide 'modular-rainbow)
;;; modular-rainbow.el ends here
