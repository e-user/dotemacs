;;; modular-term.el --- Modular multi-term module  -*- lexical-binding: t; -*-

;; Copyright (C) 2014-2016  Alexander Dorn

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

;; Load multi-term

;;; Code:
;;;###autoload
(add-to-list 'modular-features 'modular-term)

(install 'multi-term)
(require 'multi-term)

; (add-hook 'term-mode-hook #'(lambda () (hl-line-mode)))

(defvar term-index 0)

(defun multi-term+ ()
  (interactive)
  (let (term-buffer)
    ;; Set buffer.
    (setq term-buffer (multi-term-get-buffer current-prefix-arg))
    (setq multi-term-buffer-list (nconc multi-term-buffer-list (list term-buffer)))
    (set-buffer term-buffer)
    ;; Internal handle for `multi-term' buffer.
    (multi-term-internal)
    (multi-term-switch-buffer term-buffer default-directory)
    (with-current-buffer term-buffer
      (setq-local terminal-name (format "term<%d>" (incf term-index)))
      (rename-buffer (format "*%s*" terminal-name)))
    term-buffer))

(defun term-handle-ansi-terminal-messages (message)
  (while (string-match "\eAnSiT.+\n" message)
    ;; Extract the command code and the argument.
    (let* ((start (match-beginning 0))
           (command-code (aref message (+ start 6)))
           (argument
            (save-match-data
              (substring message
                         (+ start 8)
                         (string-match "\r?\n" message
                                       (+ start 8))))))
      ;; Delete this command from MESSAGE.
      (setq message (replace-match "" t t message))

      (cond ((= command-code ?c)
             (setq term-ansi-at-dir argument))
            ((= command-code ?h)
             (setq term-ansi-at-host argument))
            ((= command-code ?u)
             (setq term-ansi-at-user argument))
            ((= command-code ?e)
             (save-excursion
               (find-file-other-window argument)))
            ((= command-code ?x)
             (save-excursion
               (find-file argument))))))

  (when (and term-ansi-at-host term-ansi-at-dir term-ansi-at-user)
    (setq buffer-file-name term-ansi-at-dir)
    (when (boundp 'terminal-name)
      (rename-buffer (format "*%s: %s*" (replace-regexp-in-string "term" term-ansi-at-host terminal-name nil 'literal) term-ansi-at-dir)))
    ;; (setq default-directory (if (string= term-ansi-at-host (car (split-string (system-name) "\\.")))
    ;;                             (concatenate 'string term-ansi-at-dir "/")
    ;;                           (format "/%s@%s:%s/" term-ansi-at-user term-ansi-at-host term-ansi-at-dir)))
    (when (string= term-ansi-at-host (car (split-string (system-name) "\\.")))
      (setq default-directory (concatenate 'string term-ansi-at-dir "/"))))
  message)

(defun term-clear-modified (buffer)
  (with-current-buffer buffer
    (set-buffer-modified-p nil)))

(advice-add #'term-emulate-terminal :after #'(lambda (proc str) (term-clear-modified (process-buffer proc))))

(setq term-bind-key-alist
      (list (cons "C-c C-c" 'term-interrupt-subjob)
            (cons "C-p" 'previous-line)
            (cons "C-n" 'next-line)
            (cons "M-f" 'term-send-forward-word)
            (cons "M-b" 'term-send-backward-word)
            (cons "C-c C-j" 'term-line-mode)
            (cons "C-c C-k" 'term-char-mode)
            (cons "M-DEL" 'term-send-raw-meta)
            (cons "M-d" 'term-send-forward-kill-word)
            (cons "<C-left>" 'term-send-backward-word)
            (cons "<C-right>" 'term-send-forward-word)
            (cons "C-r" 'term-send-reverse-search-history)
            (cons "M-p" 'term-send-raw-meta)
            (cons "M-y" 'term-send-raw-meta)
            (cons "C-y" 'term-send-raw)
            (cons "<C-escape>" 'term-send-esc)
            (cons "C-v" 'scroll-up-command)))
 
(global-set-key (kbd "<f5>") 'multi-term+)
(global-set-key (kbd "<C-next>") 'multi-term-next)
(global-set-key (kbd "<C-prior>") 'multi-term-prev)
(setq multi-term-buffer-name "term"
      multi-term-program "zsh"
      multi-term-program-switches "--login"
      multi-term-try-create nil)

(provide 'modular-term)
;;; modular-term.el ends here
