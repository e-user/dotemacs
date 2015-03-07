;;; modular-cider.el --- cider init

;; Copyright (C) 2014  Alexander Kahl

;; Author: Alexander Kahl <e-user@fsfe.org>
;; Keywords: emacs, clojure, cider, nrepl, nrepl.el

;;; Code:
;;;###autoload
(add-to-list 'modular-features 'modular-cider)

(require 'modular-elpa)
(require 'modular-clojure)

(pin "melpa-stable" 'cider)

(install 'cider)

(require 'cider)
(add-hook 'cider-interaction-mode-hook
          'cider-turn-on-eldoc-mode)

(add-hook 'cider-repl-mode-hook 'paredit-mode)
(add-hook 'cider-mode-hook 'enable-paredit-mode)
(define-key cider-mode-map (kbd "<C-j>") 'nrepl-newline-and-indent)
(define-key cider-repl-mode-map (kbd "<C-j>") 'nrepl-newline-and-indent)
(define-key cider-repl-mode-map (kbd "C-c M-n") 'cider-repl-set-ns)
(setq cider-repl-tab-command 'indent-for-tab-command)
(setq cider-repl-history-file (expand-file-name "~/.cider-history"))

;(add-to-list 'package-pinned-packages '(cider . "melpa-stable") t)

(provide 'modular-cider)
;;; modular-cider.el ends here
