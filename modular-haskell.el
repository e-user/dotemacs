;;; modular-haskell.el --- Haskell init

;; Copyright (C) 2015  Alexander Kahl

;; Author: Alexander Kahl <e-user@fsfe.org>
;; Keywords: haskell

;;; Code:
;;;###autoload
(add-to-list 'modular-features 'modular-haskell)

(require 'modular-elpa)
(require 'modular-company)

(install 'haskell-mode 'hindent 'ghc 'company-ghc)
(add-hook 'haskell-mode-hook #'turn-on-haskell-indentation)
(add-hook 'haskell-mode-hook #'hindent-mode)
(autoload 'ghc-init "ghc" nil t)
(autoload 'ghc-debug "ghc" nil t)
(add-hook 'haskell-mode-hook #'(lambda () (ghc-init)))

(eval-after-load 'haskell-mode
  '(progn
     (define-key haskell-mode-map (kbd "C-c C-l") 'haskell-process-load-or-reload)
     (define-key haskell-mode-map (kbd "C-`") 'haskell-interactive-bring)
     (define-key haskell-mode-map (kbd "C-c C-n C-t") 'haskell-process-do-type)
     (define-key haskell-mode-map (kbd "C-c C-n C-i") 'haskell-process-do-info)
     (define-key haskell-mode-map (kbd "C-c C-n C-c") 'haskell-process-cabal-build)
     (define-key haskell-mode-map (kbd "C-c C-n c") 'haskell-process-cabal)))

(eval-after-load 'haskell-cabal
  '(progn
     (define-key haskell-cabal-mode-map (kbd "C-`") 'haskell-interactive-bring)
     (define-key haskell-cabal-mode-map (kbd "C-c C-k") 'haskell-interactive-ode-clear)
     (define-key haskell-cabal-mode-map (kbd "C-c C-c") 'haskell-process-cabal-build)
     (define-key haskell-cabal-mode-map (kbd "C-c c") 'haskell-process-cabal)))

(custom-set-variables
  '(haskell-process-suggest-remove-import-lines t)
  '(haskell-process-auto-import-loaded-modules t)
  '(haskell-process-log t)
  '(haskell-process-type 'cabal-repl))

(add-to-list 'company-backends 'company-ghc)

(let ((path (expand-file-name "~/.cabal/bin")))
  (setenv "PATH" (concat path ":" (getenv "PATH")))
  (add-to-list 'exec-path path))

(provide 'modular-haskell)
;;; modular-haskell.el ends here
