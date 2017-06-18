;;; modular-contextual.el --- Modular Contextual module  -*- lexical-binding: t; -*-

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

;; Load Contextual

;;; Code:
;;;###autoload
(add-to-list 'modular-features 'modular-contextual)

;;;###autoload
(pin "melpa-stable" 'contextual)
(install 'contextual)
(require 'contextual)

(contextual-add-profile "private" ()
  ((user-mail-address "ak@sodosopa.io")
   (mu4e-base-folder "/sodosopa.io")
   (mu4e-sent-folder "/sodosopa.io/Sent")
   (mu4e-drafts-folder "/sodosopa.io/Drafts")
   (mu4e-trash-folder "/sodosopa.io/Trash")
   (mu4e-refile-folder "/sodosopa.io/Archives")
   (message-signature-file "~/.signature")
   (message-sendmail-extra-arguments '("-a" "sodosopa.io"))
   (mu4e-bookmarks '(("date:7d..now AND NOT flag:trashed AND maildir:/sodosopa.io" "Inbox: One week" 105)
                     ("(flag:unread OR flag:flagged) AND NOT flag:trashed AND maildir:/sodosopa.io" "Inbox: New" 119)
                     ("(flag:unread OR flag:flagged) AND NOT flag:trashed" "All: New" 101)
                     ("date:today..now" "Today's mail" 116)
                     ("flag:flagged" "All: Flagged" 102)))
   (mu4e-get-mail-command "mbsync -q sodosopa.io")))

(contextual-add-profile "work" ()
  ((user-mail-address "alexander.kahl@oliverwyman.com")
   (message-signature-file "~/.signature.ow")))

(setq work-computers '("horkheimer.in.labshift.io" "adorno.labshift.io"))

(contextual-set-initial-profile
 (if (member system-name work-computers) "work" "private"))

(contextual-global-mode)

(defcontext font-profiles "normal")

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

(provide 'modular-contextual)
;;; modular-contextual.el ends here
