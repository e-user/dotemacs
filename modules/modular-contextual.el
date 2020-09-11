;;; modular-contextual.el --- Modular Contextual module  -*- lexical-binding: t; -*-

;; Copyright (C) 2016-2017  Alexander Dorn

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

;; Load Contextual

;;; Code:
;;;###autoload
(add-to-list 'modular-features 'modular-contextual)

;;;###autoload
(pin "melpa-stable" 'contextual)
(install 'contextual)
(require 'contextual)

(defun basic-bookmarks (maildir)
  (map 'list #'(lambda (bookmark name key)
                 (list (format bookmark maildir) name key))
       '("maildir:/%s AND date:7d..now AND NOT flag:trashed"
         "maildir:/%s AND (flag:unread OR flag:flagged) AND NOT flag:trashed"
         "maildir:/%s AND date:today..now"
         "maildir:/%s AND flag:flagged")
       '("One week" "Unread messages" "Today's mail" "All flagged")
       '(105 119 116 102)))

(contextual-add-profile "private" ()
  ((user-mail-address "ad@sodosopa.io")
   (mu4e-base-folder "/sodosopa.io")
   (mu4e-sent-folder "/sodosopa.io/Sent")
   (mu4e-drafts-folder "/sodosopa.io/Drafts")
   (mu4e-trash-folder "/sodosopa.io/Trash")
   (mu4e-refile-folder "/sodosopa.io/Archives")
   (message-sendmail-extra-arguments '("-a" "sodosopa.io"))
   (mu4e-bookmarks (basic-bookmarks "sodosopa.io"))
   (mu4e-get-mail-command "mbsync -q sodosopa.io")
   (message-signature-file "~/.signature.private")
   (mail-signature-file "~/.signature.private")))

(contextual-add-profile "solvemate.com" ()
  ((user-mail-address "a.dorn@solvemate.com")
   (mu4e-base-folder "/solvemate.com")
   (mu4e-sent-folder "/solvemate.com/[Gmail]/Sent Mail")
   (mu4e-drafts-folder "/solvemate.com/[Gmail]/Drafts")
   (mu4e-trash-folder "/solvemate.com/[Gmail]/Trash")
   (mu4e-refile-folder "/solvemate.com/[Gmail]/Archives")
   (message-sendmail-extra-arguments '("-a" "solvemate.com"))
   (mu4e-bookmarks (basic-bookmarks "solvemate.com"))
   (mu4e-get-mail-command "mbsync -q solvemate.com")
   (message-signature-file "~/.signature.solvemate")
   (mail-signature-file "~/.signature.solvemate")))

(contextual-add-profile "communicatio.systems" ()
  ((user-mail-address "a.kahl@communicatio.systems")
   (mu4e-base-folder "/communicatio.systems")
   (mu4e-sent-folder "/communicatio.systems/Sent")
   (mu4e-drafts-folder "/communicatio.systems/Drafts")
   (mu4e-trash-folder "/communicatio.systems/Trash")
   (mu4e-refile-folder "/communicatio.systems/Archive")
   (message-sendmail-extra-arguments '("-a" "communicatio.systems"))
   (mu4e-bookmarks (basic-bookmarks "communicatio.systems"))
   (mu4e-get-mail-command "mbsync -q communicatio.systems")
   (message-signature-file "~/.signature.cys")
   (mail-signature-file "~/.signature.cys")))

(contextual-add-profile "apeunit" ()
  ((user-mail-address "alexander@apeunit.com")
   (mu4e-base-folder "/apeunit.com")
   (mu4e-sent-folder "/apeunit.com/Sent")
   (mu4e-drafts-folder "/apeunit.com/Drafts")
   (mu4e-trash-folder "/apeunit.com/Trash")
   (message-sendmail-extra-arguments '("-a" "apeunit.com"))
   (mu4e-bookmarks (basic-bookmarks "apeunit.com"))
   (mu4e-get-mail-command "mbsync -q apeunit.com")))

(contextual-add-profile "tpwd.de" ()
  ((user-mail-address "ak@tpwd.de")
   (mu4e-base-folder "/tpwd.de")
   (mu4e-sent-folder "/tpwd.de/Sent")
   (mu4e-drafts-folder "/tpwd.de/Drafts")
   (mu4e-trash-folder "/tpwd.de/Trash")
   (mu4e-refile-folder "/tpwd.de/Archive")
   (message-sendmail-extra-arguments '("-a" "tpwd.de"))
   (mu4e-bookmarks (basic-bookmarks "tpwd.de"))
   (mu4e-get-mail-command "mbsync -q tpwd.de")
   (message-signature-file "~/.signature.tpwd")
   (mail-signature-file "~/.signature.tpwd")))

(contextual-add-profile "planetary-networks.de" ()
  ((user-mail-address "a.dorn@planetary-networks.de")
   (mu4e-base-folder "/planetary-networks.de")
   (mu4e-sent-folder "/planetary-networks.de/Sent")
   (mu4e-drafts-folder "/planetary-networks.de/Drafts")
   (mu4e-trash-folder "/planetary-networks.de/Trash")
   (mu4e-refile-folder "/planetary-networks.de/Archive")
   (message-sendmail-extra-arguments '("-a" "planetary-networks.de"))
   (mu4e-bookmarks (basic-bookmarks "planetary-networks.de"))
   (mu4e-get-mail-command "mbsync -q planetary-networks.de")
   (message-signature-file "~/.signature.planetary")
   (mail-signature-file "~/.signature.planetary")))

(contextual-set-initial-profile "private")

(contextual-global-mode)

(defun contextual-cycle-profile (context x)
  "Cycle through `X' profiles in `CONTEXT', wrapping over if necessary."
  (let* ((profiles (mapcar #'car (get context 'profiles)))
         (n (length profiles)))
    (nth (mod (+ x (position (get 'contextual-default-context 'active-profile) profiles :test #'equal) n) n)
         profiles)))

(defun contextual-next-profile (context)
  "The next profile defined for `CONTEXT', wrapping over if necessary."
  (contextual-cycle-profile context 1))

(defun contextual-previous-profile (context)
  "The previous profile defined for `CONTEXT', wrapping over if necessary."
  (contextual-cycle-profile context -1))

(defun contextual-activate-next-profile (context)
  "Activate the next profile defined for `CONTEXT'."
  (interactive (list (if (boundp 'context) context 'contextual-default-context)))
  (contextual-activate-profile context (contextual-next-profile context)))

(defun contextual-activate-previous-profile (context)
  "Activate the previous profile defined for `CONTEXT'."
  (interactive (list (if (boundp 'context) context 'contextual-default-context)))
  (contextual-activate-profile context (contextual-previous-profile context)))

(global-set-key (kbd "<M-s-right>") #'contextual-activate-next-profile)
(global-set-key (kbd "<M-s-left>") #'contextual-activate-previous-profile)

(provide 'modular-contextual)
;;; modular-contextual.el ends here
