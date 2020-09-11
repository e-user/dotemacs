;;; modular-activitywatch.el --- Modular activitywatch module  -*- lexical-binding: t; -*-

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

;; Load activitywatch

;;; Code:
;;;###autoload
(add-to-list 'modular-features 'modular-activitywatch)

;;;###autoload
(pin "melpa-stable" 'activity-watch-mode)

(install 'activity-watch-mode)

; (global-activity-watch-mode)

(defun activity-watch--send-heartbeat (heartbeat)
  "Send HEARTBEAT to activity watch server."
  (request (concat activity-watch-api-host "/api/0/buckets/" (activity-watch--bucket-id) "/heartbeat")
           :type "POST"
           :params `(("pulsetime" . ,activity-watch-pulse-time))
           :data (json-encode heartbeat)
           :headers '(("Content-Type" . "application/json"))))

(provide 'modular-activitywatch)
;;; modular-activitywatch.el ends here
