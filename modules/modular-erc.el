;;; modular-docker.el --- Modular Erc module      -*- lexical-binding: t; -*-

;; Copyright © 2014, 2018 Alexander Dorn

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

;; Load Erc

;;; Code:
;;;###autoload
(add-to-list 'modular-features 'modular-erc)

(require 'tls)
(require 'erc)
(require 'erc-services)
(require 'erc-desktop-notifications)

(setq erc-autojoin-channels-alist
      '(("freenode.net" "#nixos" "#nixos-dev")))

(erc-services-mode 1)
(erc-notifications-mode 1)

(defun start-erc ()
  (interactive)
  ;(erc :server "localhost" :port 6667 :nick "e-user" :full-name (user-full-name))
  (erc-tls :server "irc.freenode.net" :port 6697 :nick "e-user" :full-name (user-full-name)))

(provide 'modular-erc)
;;; modular-erc.el ends here
