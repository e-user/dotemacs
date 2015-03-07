;;; modular-erc.el --- Erc init

;; Copyright (C) 2014  Alexander Kahl

;; Author: Alexander Kahl <e-user@fsfe.org>
;; Keywords: erc

;;; Code:
;;;###autoload
(add-to-list 'modular-features 'modular-erc)

(require 'erc)
(require 'notifications)

;; Source: http://www.emacswiki.org/emacs/BitlBee#toc11

;; Association list, pairing buffer names with notification IDs.

(setq erc-notification-id-alist '())

;; Function for use by erc-new-message-notify.

(defun erc-notification-closed (id reason)
  "Callback function, for removing notification entry if user closed notification manually."
  (dolist (entry erc-notification-id-alist)
    (if (equal id (cdr entry))
        (setq erc-notification-id-alist
              (delq
               (assoc (car entry) erc-notification-id-alist)
               erc-notification-id-alist)))))

;; Create notification when ERC message received.

(defun erc-new-message-notify (message)
  "Notify user of new ERC message."
  (let ((this-buffer (buffer-name (current-buffer))))
    (if (not (string-match "^[#&]" this-buffer))
        (if (not (assoc this-buffer erc-notification-id-alist))
            (setq erc-notification-id-alist
                  (cons
                   `(,this-buffer ,@(notifications-notify :timeout 0 :app-icon "/usr/share/icons/hicolor/scalable/apps/im-irc.svg" :on-close 'erc-notification-closed :title "New message in chat" :body (buffer-name (current-buffer))))
                   erc-notification-id-alist))))))

; TODO reactivate when dbus fixed
; (add-hook 'erc-insert-pre-hook 'erc-new-message-notify)

;; Start of workaround https://lists.gnu.org/archive/html/bug-gnu-emacs/2013-12/msg00117.html
(when (or (< emacs-major-version 24)
          (and (= emacs-major-version 24)
               (<= emacs-minor-version 3)))
  (defun notifications-close-notification (id &optional bus)
    "Close a notification with identifier ID.
BUS can be a string denoting a D-Bus connection, the default is `:session'."
    (dbus-call-method (or bus :session)
                      notifications-service
                      notifications-path
                      notifications-interface
                      notifications-close-notification-method
                      :uint32 id))) ;; <- fix
;; End of workaround

;; On ERC buffer modification by user, clear notification message.

(defun erc-close-notification ()
  "Close ERC notification bubbles related to the current chat."
  (let ((this-buffer (buffer-name (current-buffer))))
    (if (assoc this-buffer erc-notification-id-alist)
        (progn
          (notifications-close-notification (cdr (assoc this-buffer erc-notification-id-alist)))
          (setq erc-notification-id-alist
                (delq
                 (assoc this-buffer erc-notification-id-alist)
                 erc-notification-id-alist))))))

; TODO reactivate when dbus fixed
; (add-hook 'erc-send-post-hook 'erc-close-notification)

(provide 'modular-erc)
;;; modular-erc.el ends here
