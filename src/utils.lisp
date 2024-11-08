;;;; natsukashii -- automated web archive scraper for fanfiction.net
;;;; Copyright (C) 2022 Mii

;;;; This program is free software: you can redistribute it and/or modify
;;;; it under the terms of the GNU Affero General Public License as published by
;;;; the Free Software Foundation, either version 3 of the License, or
;;;; (at your option) any later version.

;;;; This program is distributed in the hope that it will be useful,
;;;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;;;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;;;; GNU Affero General Public License for more details.

;;;; You should have received a copy of the GNU Affero General Public License
;;;; along with this program.  If not, see <https://www.gnu.org/licenses/>

;;;; Utility functions and macros that are useful in many places.

(in-package :natsukashii)

(defmacro with-cdx-query ((uri &key map-with) &body body)
  "Fire a query against the CDX API with URI and then execute BODY with the result.
Optionally map the results with MAP-WITH.
The macro provides the anaphors RESPONSE and STATUS-CODE."
  (let ((return-value (gensym)))
    `(multiple-value-bind (,return-value status-code)
         (dex:get (concatenate 'string *cdx-url* (quri:url-encode ,uri)))
       (when (and (eql status-code 200) (str:non-empty-string-p ,return-value))
         (let ((response
                 (if ,map-with
                     (mapcar ,map-with (ppcre:split "\\n" ,return-value))
                     (ppcre:split "\\n" ,return-value))))
           ,@body)))))

(defstruct memento
  (url-key "" :type string :read-only t)
  (timestamp "" :type string :read-only t)
  (url "" :type string :read-only t))

(defun format-categories (category-array)
  "Format strings in CATEGORY-ARRAY so that they work as filepaths."
  (remove-if (lambda (str) (every #'digit-char-p str))
             (map 'list #'str:pascal-case category-array)))

(defun strip-scripts (node)
  "Remove all script elements from NODE using lQuery."
  (lquery:$ node "script" (detach))
  node)

(defun parse-cdx-response (line)
  "Format one LINE of a CDX response into a `memento'."
  (destructuring-bind (url-key timestamp original mimetype statuscode digest length)
      (ppcre:split "\\s" line)
    (declare (ignore mimetype digest length))
    (when (string= statuscode "200")
      (make-memento :url-key url-key :url original :timestamp timestamp))))
