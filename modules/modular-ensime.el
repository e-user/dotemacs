;;; modular-ensime.el --- ENSIME Scala support       -*- lexical-binding: t; -*-

;; Copyright © 2015  Alexander Kahl

;; Author: Alexander Kahl <e-user@fsfe.org>
;; Keywords: languages

;;; Code:
;;;###autoload
(add-to-list 'modular-features 'modular-ensime)

(install 'ensime)
(require 'ensime)

(add-hook 'scala-mode-hook 'ensime-scala-mode-hook)

(setq ensime-auto-generate-config t
      ensime-sbt-command "sbt")

(provide 'modular-ensime)
;;; modular-ensime.el ends here
