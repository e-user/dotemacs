;;; modular-dired.el --- Dired init

;; Copyright © 2014  Alexander Dorn

;; Author: Alexander Dorn <ad@sodosopa.io>
;; Keywords: dired

;;; Code:
;;;###autoload
(add-to-list 'modular-features 'modular-dired)

(require 'dired)
(put 'dired-find-alternate-file 'disabled nil)
(define-key dired-mode-map (kbd "RET") 'dired-find-alternate-file)
(define-key dired-mode-map (kbd "<backspace>") 'dired-up-directory)

(defun dired-open-file ()
  "In dired, open the file named on this line."
  (interactive)
  (let* ((file (dired-get-filename nil t)))
    (message "Opening %s..." file)
    (call-process "xdg-open" nil 0 nil file)
    (message "Opening %s done" file)))

(define-key dired-mode-map (kbd "<C-return>") #'dired-open-file)

(require 'dired-extension nil t)

(define-key dired-mode-map "\M-o" nil)

(setq dired-listing-switches "-alh")

(provide 'modular-dired)
;;; modular-dired.el ends here
