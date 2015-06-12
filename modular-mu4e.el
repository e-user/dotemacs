;;; modular-mu4e.el --- Initialize mu4e

;; Copyright (C) 2015  Alexander Kahl

;; Author: Alexander Kahl <e-user@fsfe.org>
;; Keywords: mu4e, mail

;;; Code:
;;;###autoload
(add-to-list 'modular-features 'modular-mu4e)

(require 'modular-elpa)

(when (file-accessible-directory-p (expand-file-name ".nix-profile/share/emacs/site-lisp/mu4e"))
  (add-to-list 'load-path (expand-file-name ".nix-profile/share/emacs/site-lisp/mu4e"))
  (require 'mu4e)
  (require 'org-mu4e)
  (global-set-key (kbd "<f6>") #'(lambda ()
                                   (interactive)
                                   (mu4e)))

  (setq mu4e-mu-binary (expand-file-name "~/.nix-profile/bin/mu")
        mu4e-update-interval 600
        mu4e-show-images t
        mu4e-use-fancy-chars t
        mu4e-confirm-quit nil
        mu4e-update-interval nil
        mu4e-headers-sort-revert t
        ;mu4e-html2text-command "html2text -utf8 -width 80" alternative, fucks up encoding
        mu4e-html2text-command (format "pandoc -f html -t plain --columns=%d" fill-column)
        mail-user-agent 'mu4e-user-agent
        sendmail-program (executable-find "msmtp")
        message-send-mail-function 'message-send-mail-with-sendmail
        smtpmail-debug-info nil
        smtpmail-debug-verb nil
        mu4e-view-prefer-html t
        mu4e-compose-signature t
        mu4e-attachment-dir "~/Downloads")

  (defun mu4e-find-references ()
    (interactive)
    (mu4e-headers-search (mapconcat 'identity
                                    (mapcar (lambda (s)
                                              (concat "msgid:" s))
                                            (cons (mu4e-field-at-point :message-id)
                                                  (mu4e-field-at-point :references))) 
                                    " OR ")
                         nil nil t))

  (define-key mu4e-view-mode-map (kbd "^") #'mu4e-find-references)
  (add-hook 'mu4e-view-mode-hook #'(lambda ()
                                     (setq truncate-lines nil)))

  (defun mu4e-work-switch (at-work)
    (if at-work
        (setq mu4e-sent-folder "/work/[Gmail].Sent Mail"
              mu4e-drafts-folder "/work/[Gmail].Drafts"
              mu4e-trash-folder "/work/[Gmail].Trash"
              message-signature-file "~/.signature.lshift"
              message-sendmail-extra-arguments '("-a" "lshift")
              mu4e-bookmarks '(("NOT flag:trashed AND maildir:/work/INBOX AND NOT list:" "Inbox: Non-List" 97)
                               ("flag:unread AND maildir:/work/INBOX" "Inbox: Unread" 117)
                               ("NOT flag:trashed AND maildir:/work/INBOX AND list:team.lshift.de" "Inbox: Team List" 116)))
      (setq mu4e-sent-folder "/private/INBOX.Sent"
            mu4e-drafts-folder "/private/INBOX.Drafts"
            mu4e-trash-folder "/private/INBOX.Trash"
            mu4e-refile-folder "/private/INBOX.Archives"
            message-signature-file "~/.signature"
            message-sendmail-extra-arguments '("-a" "fsfe")
            mu4e-bookmarks '(("date:7d..now AND NOT flag:trashed AND maildir:/INBOX" "Inbox: One week" 105)
                             ("(flag:unread OR flag:flagged) AND NOT flag:trashed AND maildir:/INBOX" "Inbox: New" 119)
                             ("(flag:unread OR flag:flagged) AND NOT flag:trashed" "All: New" 101)
                             ("date:today..now" "Today's mail" 116)
                             ("flag:flagged" "All: Flagged" 102)))))
  (add-hook 'work-context-hook #'(lambda (at-work) (mu4e-work-switch at-work)))

  (require 'gnus-dired)
  ;; make the `gnus-dired-mail-buffers' function also work on
  ;; message-mode derived modes, such as mu4e-compose-mode
  (defun gnus-dired-mail-buffers ()
    "Return a list of active message buffers."
    (let (buffers)
      (save-current-buffer
        (dolist (buffer (buffer-list t))
          (set-buffer buffer)
          (when (and (derived-mode-p 'message-mode)
                     (null message-sent-message-via))
            (push (buffer-name buffer) buffers))))
      (nreverse buffers)))
  
  (setq gnus-dired-mail-mode 'mu4e-user-agent)
  (add-hook 'dired-mode-hook 'turn-on-gnus-dired-mode)

  (defun mu4e-action-view-in-browser-fixup-encoding (msg)
    (let* ((html (mu4e-message-field msg :body-html))
           (txt (mu4e-message-field msg :body-txt))
           (tmpfile (format "%s%x.html" temporary-file-directory (random t))))
      (unless (or html txt)
        (mu4e-error "No body part for this message"))
      (with-temp-buffer
        ;; simplistic -- but note that it's only an example...
        (insert (or html (concat "<pre>" txt "</pre>")))
        (write-file tmpfile)
        (when html
          (shell-command (format "html-charset-fixup %s %s" tmpfile "utf-8")))
        (browse-url (concat "file://" tmpfile)))))
  
  (define-key mu4e-view-mode-map (kbd ",") #'(lambda ()
                                               (interactive)
                                               (mu4e-action-view-in-browser-fixup-encoding (mu4e-message-at-point)))))

(provide 'modular-mu4e)
;;; modular-mu4e.el ends here
