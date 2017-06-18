;;; modular-helm.el --- Modular Helm module          -*- lexical-binding: t; -*-

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

;; Load Helm

;;; Code:
;;;###autoload
(add-to-list 'modular-features 'modular-helm)

;;;###autoload
(pin "melpa-stable" 'helm 'helm-core 'helm-projectile)

(install 'helm 'helm-projectile)

(require 'helm-config)
(require 'helm-projectile)

(setq helm-net-prefer-curl t
      helm-split-window-in-side-p t
      helm-buffers-fuzzy-matching t
      helm-move-to-line-cycle-in-source t
      ; workaround
      helm-follow-mode nil)

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
(define-key helm-map (kbd "C-.") 'helm-execute-persistent-action)
(define-key helm-read-file-map (kbd "C-.") 'helm-execute-persistent-action)
(define-key projectile-command-map (kbd "b") #'helm-projectile-switch-to-buffer)


(eval-after-load 'projectile
  '(define-key projectile-command-map (kbd "s g") #'helm-projectile-grep))

(provide 'modular-helm)
;;; modular-helm.el ends here
