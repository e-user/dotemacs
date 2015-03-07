;;; modular-paredit.el --- Initialize Paredit

;; Copyright (C) 2012, 2014  Alexander Kahl

;; Author: Alexander Kahl <e-user@fsfe.org>
;; Keywords: paredit

;;; Code:
;;;###autoload
(add-to-list 'modular-features 'modular-paredit)

(require 'modular-elpa)
(install 'paredit)

(require 'paredit)
(add-hook 'lisp-mode-hook             (lambda () (paredit-mode +1)))
(add-hook 'lisp-interaction-mode-hook (lambda () (paredit-mode +1)))
(define-key paredit-mode-map (kbd "<C-right>") 'paredit-forward)
(define-key paredit-mode-map (kbd "<C-left>") 'paredit-backward)
(define-key paredit-mode-map (kbd "<M-right>") 'paredit-forward-slurp-sexp)
(define-key paredit-mode-map (kbd "<M-left>") 'paredit-forward-barf-sexp)

(eval-after-load "clojure-mode"
  '(progn
     (require 'clojure-mode) ; clojure-mode-map isn't autoloaded
     (add-hook 'clojure-mode-hook (lambda () (paredit-mode +1)))
     (define-key clojure-mode-map (kbd "RET") (lambda ()
                                                (interactive)
                                                (paredit-newline)))))
(eval-after-load "slime"
  '(progn
     (add-hook 'slime-mode-hook      (lambda () (paredit-mode +1)))
     (add-hook 'slime-repl-mode-hook (lambda () (paredit-mode +1)))))

; for elisp
(eval-after-load "lisp-mode"
  '(progn
     (require 'lisp-mode)
     (add-hook 'emacs-lisp-mode-hook (lambda () (paredit-mode +1)))
     (define-key emacs-lisp-mode-map (kbd "RET") 'paredit-newline)))

(provide 'modular-paredit)
;;; modular-paredit.el ends here
