;;; modular-request.el --- Modular request module    -*- lexical-binding: t; -*-

;; Copyright (C) 2019  Alexander Dorn

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
;; along with this program.  If not, see <https://www.gnu.org/licenses/>.

;;; Commentary:

;; Load request

;;; Code:
;;;###autoload
(add-to-list 'modular-features 'modular-request)

(install 'request)
(require 'request)

(defun request--make-temp-file ()
  "Create a temporary file."
  (if (file-remote-p default-directory)
      (let ((temporary-file-directory
	     (tramp-get-remote-tmpdir (tramp-dissect-file-name default-directory))))
	(make-temp-file request-temp-prefix))
    (make-temp-file request-temp-prefix)))

(cl-defun request--curl (url &rest settings
                             &key type data files headers timeout response
                             &allow-other-keys)
  "cURL-based request backend.

Redirection handling strategy
-----------------------------

curl follows redirection when --location is given.  However,
all headers are printed when it is used with --include option.
Number of redirects is printed out sexp-based message using
--write-out option (see `request--curl-write-out-template').
This number is used for removing extra headers and parse
location header from the last redirection header.

Sexp at the end of buffer and extra headers for redirects are
removed from the buffer before it is shown to the parser function.
"
  (request--curl-mkdir-for-cookie-jar)
  (let* (;; Use pipe instead of pty.  Otherwise, curl process hangs.
         (process-connection-type nil)
         ;; Avoid starting program in non-existing directory.
         (home-directory (or (file-remote-p default-directory) "~/"))
         (default-directory (expand-file-name home-directory))
         (buffer (generate-new-buffer " *request curl*"))
         (command (cl-destructuring-bind
                      (files* tempfiles)
                      (request--curl-normalize-files files)
                    (setf (request-response--tempfiles response) tempfiles)
                    (apply #'request--curl-command url :files* files*
                           :response response settings)))
         (proc (apply #'start-file-process "request curl" buffer command)))
    (request-log 'debug "Run: %s" (mapconcat 'identity command " "))
    (setf (request-response--buffer response) buffer)
    (process-put proc :request-response response)
    (set-process-coding-system proc 'binary 'binary)
    (set-process-query-on-exit-flag proc nil)
    (set-process-sentinel proc #'request--curl-callback)))

(provide 'modular-request)
;;; modular-request.el ends here
