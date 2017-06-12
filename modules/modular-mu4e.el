;;; modular-mu4e.el --- Initialize mu4e

;; Copyright © 2015, 2016  Alexander Kahl

;; Author: Alexander Kahl <ak@sodosopa.io>
;; Keywords: mu4e, mail

;;; Code:
;;;###autoload
(add-to-list 'modular-features 'modular-mu4e)

(when-let ((dir (first (file-expand-wildcards "/nix/store/*mu*/share/emacs/site-lisp/mu4e"))))
  (add-to-list 'load-path dir))

(when (require 'mu4e nil t)
  (install 'mu4e-alert)
  (require 'mu4e-alert)
  (mu4e-alert-set-default-style 'notifications)
  (mu4e-alert-enable-notifications)
  (mu4e-alert-enable-mode-line-display)

  (require 'mu4e-contrib)
  
  (require 'org-mu4e)
  (global-set-key (kbd "<f6>") #'(lambda ()
                                   (interactive)
                                   (mu4e)))

  (setq mu4e-mu-binary (executable-find "mu")
        mu4e-update-interval 600
        mu4e-show-images t
        mu4e-use-fancy-chars t
        mu4e-confirm-quit nil
        mu4e-update-interval nil
        mu4e-headers-sort-revert t
        ;mu4e-html2text-command "html2text -utf8 -width 80" alternative, fucks up encoding
        ;mu4e-html2text-command (format "iconv -c -t utf-8 | pandoc -f html -t plain --columns=%d" fill-column)
        mu4e-html2text-command 'mu4e-shr2text
        mail-user-agent 'mu4e-user-agent
        sendmail-program (executable-find "msmtp")
        message-send-mail-function 'message-send-mail-with-sendmail
        smtpmail-debug-info nil
        smtpmail-debug-verb nil
        mu4e-view-prefer-html t
        mu4e-compose-signature t
        mu4e-attachment-dir "~/Downloads"
        mu4e-change-filenames-when-moving t
        mu4e-headers-date-format "%F"
        mu4e-headers-time-format "%R"
        mu4e-view-date-format "%F %R %Z"
        mml-secure-openpgp-encrypt-to-self t
        mml-secure-openpgp-sign-with-sender t
        shr-color-visible-luminance-min 80
        mu4e-completing-read-function 'completing-read)

  (setenv "MU_GPG_PATH" (executable-find "gpg2"))

  (add-hook 'mu4e-compose-mode-hook 'mml-secure-message-sign-pgpmime)

  (defun mu4e-find-references ()
    (interactive)
    (mu4e-headers-search (mapconcat 'identity
                                    (mapcar (lambda (s)
                                              (concat "msgid:" s))
                                            (cons (mu4e-field-at-point :message-id)
                                                  (mu4e-field-at-point :references))) 
                                    " OR ")
                         nil nil t))

  (defun mu4e-tags (maildir)
    (delete-dups (process-lines mu4e-mu-binary "find" (format "m:%s" maildir) "-f" "x")))

  (defvar mu4e-base-folder nil)

  (defun mu4e~headers-jump-to-tag (tag)
    (interactive
     (let ((tag (funcall mu4e-completing-read-function "Tag: " (mu4e-tags mu4e-base-folder))))
       (list tag)))
    (when tag
      (mu4e-mark-handle-when-leaving)
      (mu4e-headers-search (format "maildir:\"%s\" tag:%s" mu4e-base-folder tag))))
  
  (define-key mu4e-headers-mode-map "x" 'mu4e~headers-jump-to-tag)
  (define-key mu4e-main-mode-map "x" 'mu4e~headers-jump-to-tag)

  (define-key mu4e-view-mode-map (kbd "^") #'mu4e-find-references)
  (add-hook 'mu4e-view-mode-hook #'(lambda ()
                                     (setq truncate-lines nil)))

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
