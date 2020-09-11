;;; modular-helm.el --- Modular Helm module          -*- lexical-binding: t; -*-

;; Copyright (C) 2016, 2019  Alexander Dorn

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

;; Load Helm

;;; Code:
;;;###autoload
(add-to-list 'modular-features 'modular-helm)

;;;###autoload
(pin "melpa-stable" 'helm 'helm-core 'helm-projectile 'helm-company)

(install 'helm 'helm-projectile 'helm-company)

(require 'modular-company)
(require 'modular-projectile)

(require 'helm-config)
(require 'helm-projectile)

(setq helm-net-prefer-curl t
      helm-split-window-inside-p t
      helm-always-two-windows nil
      helm-buffers-fuzzy-matching t
      helm-move-to-line-cycle-in-source t
      ; workaround
      helm-follow-mode nil
      helm-apropos-fuzzy-match t)

(global-set-key (kbd "C-c h") 'helm-command-prefix)
(global-unset-key (kbd "C-x c"))

(helm-mode t)

(global-set-key (kbd "M-x") 'helm-M-x)
(global-set-key (kbd "M-y") 'helm-show-kill-ring)
(global-set-key (kbd "C-x b") 'helm-mini)
(global-set-key (kbd "C-x C-b") 'helm-buffers-list)
(global-set-key (kbd "C-x C-f") 'helm-find-files)
(global-set-key (kbd "C-h f") 'helm-apropos)
(global-set-key (kbd "C-h r") 'helm-info-emacs)
(global-set-key (kbd "C-h C-l") 'helm-locate-library)
(global-set-key (kbd "C-c C-d") 'helm-apropos)
(define-key helm-map (kbd "C-.") 'helm-execute-persistent-action)
(define-key helm-map (kbd "<left>") 'helm-previous-source)
(define-key helm-map (kbd "<right>") 'helm-next-source)
(define-key helm-read-file-map (kbd "C-.") 'helm-execute-persistent-action)
(define-key projectile-command-map (kbd "b") #'helm-projectile-switch-to-buffer)
(define-key projectile-command-map (kbd "p") #'helm-projectile-switch-project)

(define-key projectile-command-map (kbd "s g") #'helm-projectile-grep)

(define-key company-mode-map (kbd "C-.") 'helm-company)
(define-key company-active-map (kbd "C-.") 'helm-company)

(provide 'modular-helm)
;;; modular-helm.el ends here
