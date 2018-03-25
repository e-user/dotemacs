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
   (mu4e-get-mail-command "true")))

(contextual-set-initial-profile "private")

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

(install 'uuidgen)
(require 'uuidgen)

;; (uuidgen nil)
(defconst uuidgen-ns-xrandr "1f5e2260-7b55-49df-9d5b-0e180939d033")

(defun run-xrandr ()
  "Run `xrandr' and return its trimmed output."
  (string-trim (shell-command-to-string "xrandr")))

(defun xrandr-uuid ()
  "Generate UUIDv5 for xrandr output."
  (uuidgen-5 uuidgen-ns-xrandr (run-xrandr)))

(contextual-activate-profile 'font-profiles
  (let ((uuid (xrandr-uuid)))
    (cond
     ((string-equal uuid "63379ca1-0b7b-5d94-bdfa-b5d290e3ef4d") "normal")
     ((string-equal uuid "95eb2791-0d71-54d1-8d1f-ec282e798d60") "large")
     ((string-equal uuid "acdcdf67-fcb7-5756-8a10-af6e9f2ef3a1") "large")
     (t "normal"))))

(provide 'modular-contextual)
;;; modular-contextual.el ends here
