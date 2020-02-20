;;; modular-org.el --- Modular Org module            -*- lexical-binding: t; -*-

;; Copyright (C) 2016-2020  Alexander Dorn

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

;; Load org

;;; Code:
;;;###autoload
(add-to-list 'modular-features 'modular-org)

(require 'org)
(require 'org-capture)
(require 'org-agenda)
(require 'org-clock)

(define-key global-map "\C-cl" 'org-store-link)
(define-key global-map "\C-ca" 'org-agenda)
(define-key global-map "\C-cb" 'org-iswitchb)
(define-key global-map "\C-cg" 'org-clock-goto)
(define-key global-map "\C-cc" 'org-capture)

(define-key org-mode-map (kbd "<S-left>") nil)
(define-key org-mode-map (kbd "<S-right>") nil)

(define-key org-agenda-mode-map (kbd "<S-left>") nil)
(define-key org-agenda-mode-map (kbd "<S-right>") nil)
(define-key org-agenda-mode-map (kbd "<return>") 'org-agenda-show)

(define-key org-mode-map (kbd "M-}") 'org-forward-paragraph)
(define-key org-mode-map (kbd "M-{") 'org-backward-paragraph)

(defvar org-gtd-file "~/Nextcloud/cloud.sodosopa.io/Documents/gtd")
(defvar org-notes-file "~/Nextcloud/cloud.sodosopa.io/Documents/notes.org")

;; (define-key org-mode-map "\C-\M-j" 'org-insert-todo-heading)
;; (define-key org-mode-map "\C-j" 'org-insert-heading)
(let ((review '((org-agenda-show-all-dates t)
                (org-agenda-start-with-log-mode t)
                (org-agenda-start-with-clockreport-mode t)
                (org-agenda-archives-mode t))))
  (setq org-agenda-files (list org-gtd-file)
        org-log-done 'time
        org-hide-leading-stars t
        org-use-fast-todo-selection t
        org-treat-S-cursor-todo-selection-as-state-change nil
        org-directory "~/Documents/"
        org-default-notes-file org-notes-file
        org-capture-templates `(("t" "Todo" entry (file+headline ,org-gtd-file "Tasks")
                                 "* TODO %?\n%U\n%a\n" :clock-in t :clock-resume t)
                                ("n" "Note" entry (file+headline ,org-notes-file "Notes")
                                 "* %? :NOTE:\n%U\n%a\n"))
        org-stuck-projects '("WORK/-DONE|PRIVATE/-DONE" ("TODO" "NEXT") nil "")
        org-todo-state-tags-triggers '(("CANCELLED" ("CANCELLED" . t))
                                       ("WAITING" ("WAITING" . t))
                                       ("HOLD" ("WAITING" . t) ("HOLD" . t))
                                       (done ("WAITING") ("HOLD"))
                                       ("TODO" ("WAITING") ("CANCELLED") ("HOLD"))
                                       ("NEXT" ("WAITING") ("CANCELLED") ("HOLD"))
                                       ("DONE" ("WAITING") ("CANCELLED") ("HOLD")))
        org-refile-use-outline-path 'file
        org-refile-targets '((org-agenda-files . (:level . 1)))
        org-outline-path-complete-in-steps nil
        org-todo-keywords '((sequence "TODO(t)" "NEXT(n)" "|" "DONE(d!/!)")
                            (sequence "WAITING(w@/!)" "HOLD(h@/!)" "|" "CANCELLED(c@/!)"))
        org-startup-indented t
        org-agenda-custom-commands `(("N" "Notes" tags "NOTE"
                                      ((org-agenda-overriding-header "Notes")
                                       (org-tags-match-list-sublevels t)))
                                     ("h" "Habits" tags-todo "STYLE=\"habit\""
                                      ((org-agenda-overriding-header "Habits")
                                       (org-agenda-sorting-strategy
                                        '(todo-state-down effort-up category-keep))))
                                     ("n" "Next Tasks" tags-todo "-WAITING-CANCELLED/!NEXT"
                                      ((org-agenda-overriding-header "Next Tasks")
                                       (org-agenda-todo-ignore-scheduled t)
                                       (org-agenda-todo-ignore-deadlines t)
                                       (org-agenda-todo-ignore-with-date t)
                                       (org-tags-match-list-sublevels t)
                                       (org-agenda-sorting-strategy
                                        '(todo-state-down effort-up category-keep))))
                                     ("rd" "Review" agenda "day"
                                      (,@review
                                       (org-agenda-span 'day)
                                       (org-agenda-overriding-header "Day in Review")))
                                     ("rw" "Review" agenda "week"
                                      (,@review
                                       (org-agenda-span 'week)
                                       (org-agenda-start-on-weekday 0)
                                       (org-agenda-overriding-header "Week in Review")))
                                     ("rm" "Review" agenda "month"
                                      (,@review
                                       (org-agenda-span 'month)
                                       (org-agenda-start-day "01")
                                       (org-read-date-prefer-future nil)
                                       (org-agenda-overriding-header "Month in Review"))))
        org-clock-persist 'history
        org-log-into-drawer t
        org-duration-format (quote h:mm)))

(org-clock-persistence-insinuate)

;; #+SEQ_TODO: TODO(t) HOLD(h) NEXT(n) WAITING(w) DELEGATED(!) | DONE(d) CANCELLED(c)
;; #+TAGS: { PRIVATE(p) WORK(w) }

;; org-habit
(add-to-list 'org-modules 'org-habit)

(when (require 'ox-latex nil t)
  (add-to-list 'org-latex-classes
               '("tufte-handout" 
                 "\\documentclass{tufte-handout}"
                 ("\\section{%s}" . "\\section*{%s}")
                 ("\\subsection{%s}" . "\\subsection*{%s}")
                 ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
                 ("\\subsubsubsection{%s}" . "\\subsubsubsection*{%s}")
                 ("\\paragraph{%s}" . "\\paragraph*{%s}")
                 ("\\subparagraph{%s}" . "\\subparagraph*{%s}")))

  ;; tetex
  ;; (setq-default TeX-engine 'xetex)
  ;; (setq org-latex-to-pdf-process
  ;;       '("xelatex -interaction nonstopmode -output-directory %o %f"
  ;;         "xelatex -interaction nonstopmode -output-directory %o %f"
  ;;         ;; use below command(s) to convert latex fragments
  ;;         ("xelatex %f")))

  ;; latex
  (setq org-latex-pdf-process
        '("pdflatex -interaction nonstopmode -output-directory %o %f" "pdflatex -interaction nonstopmode -output-directory %o %f" "pdflatex -interaction nonstopmode -output-directory %o %f"))
  (setq-default TeX-engine 'latex))

(provide 'modular-org)
;;; modular-org.el ends here
