;;; modular-contextual.el --- Modular Contextual module  -*- lexical-binding: t; -*-

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
  ((user-mail-address "ak@sodosopa.io")
   (mu4e-base-folder "/sodosopa.io")
   (mu4e-sent-folder "/sodosopa.io/Sent")
   (mu4e-drafts-folder "/sodosopa.io/Drafts")
   (mu4e-trash-folder "/sodosopa.io/Trash")
   (mu4e-refile-folder "/sodosopa.io/Archives")
   (message-sendmail-extra-arguments '("-a" "sodosopa.io"))
   (mu4e-bookmarks (basic-bookmarks "sodosopa.io"))
   (mu4e-get-mail-command "mbsync -q sodosopa.io")))

(contextual-add-profile "apeunit" ()
  ((user-mail-address "alexander@apeunit.com")
   (mu4e-base-folder "/apeunit.com")
   (mu4e-sent-folder "/apeunit.com/Sent")
   (mu4e-drafts-folder "/apeunit.com/Drafts")
   (mu4e-trash-folder "/apeunit.com/Trash")
   (message-sendmail-extra-arguments '("-a" "apeunit.com"))
   (mu4e-bookmarks (basic-bookmarks "apeunit.com"))
   (mu4e-get-mail-command "mbsync -q apeunit.com")))

(contextual-set-initial-profile "private")

(contextual-global-mode)

(provide 'modular-contextual)
;;; modular-contextual.el ends here
