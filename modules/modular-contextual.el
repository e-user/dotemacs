;;; modular-contextual.el --- Modular Contextual module  -*- lexical-binding: t; -*-

;; Copyright (C) 2016  Alexander Kahl

;; Author: Alexander Kahl <e-user@fsfe.org>
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

(add-to-list 'load-path (expand-file-name "~/.emacs.d/contextual"))
(require 'contextual)

(contextual-add-profile "private" ()
  ((user-mail-address "e-user@fsfe.org")
   (epg-user-id "2147C35D")
   (mu4e-sent-folder "/private/INBOX.Sent")
   (mu4e-drafts-folder "/private/INBOX.Drafts")
   (mu4e-trash-folder "/private/INBOX.Trash")
   (mu4e-refile-folder "/private/INBOX.Archives")
   (message-signature-file "~/.signature")
   (message-sendmail-extra-arguments '("-a" "fsfe"))
   (mu4e-bookmarks '(("date:7d..now AND NOT flag:trashed AND maildir:/private/INBOX" "Inbox: One week" 105)
                     ("(flag:unread OR flag:flagged) AND NOT flag:trashed AND maildir:/private/INBOX" "Inbox: New" 119)
                     ("(flag:unread OR flag:flagged) AND NOT flag:trashed" "All: New" 101)
                     ("date:today..now" "Today's mail" 116)
                     ("flag:flagged" "All: Flagged" 102)))))

(contextual-add-profile "work" ()
  ((user-mail-address "alex@lshift.de")
   (epg-user-id "00CE441F")
   (mu4e-sent-folder "/work/[Gmail].Sent Mail")
   (mu4e-drafts-folder "/work/[Gmail].Drafts")
   (mu4e-trash-folder "/work/[Gmail].Trash")
   (message-signature-file "~/.signature.lshift")
   (message-sendmail-extra-arguments '("-a" "lshift"))
   (mu4e-bookmarks '(("NOT flag:trashed AND maildir:/work/INBOX AND NOT list:" "Inbox: Non-List" 97)
                     ("flag:unread AND maildir:/work/INBOX" "Inbox: Unread" 117)
                     ("NOT flag:trashed AND maildir:/work/INBOX AND list:team.lshift.de" "Inbox: Team List" 116)))))

(contextual-set-initial-profile
 (if (string= system-name "nietzsche.in.lshift.de") "work" "private"))

(contextual-global-mode)

(defcontext font-profiles "normal")

(contextual-add-profile "small" (font-profiles) ((default-frame-alist '((font . "Inconsolata-6"))))
  (set-frame-font "Inconsolata-6"))
(contextual-add-profile "normal" (font-profiles) ((default-frame-alist '((font . "Inconsolata-9"))))
  (set-frame-font "Inconsolata-9"))

(contextual-define-context-loader font-profile-loader
  font-profiles (kbd "f"))

(provide 'modular-contextual)
;;; modular-contextual.el ends here
