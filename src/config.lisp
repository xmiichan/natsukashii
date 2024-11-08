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

(in-package :natsukashii)

(defparameter *cdx-url* "http://web.archive.org/cdx/search/cdx?to=2002&url="
  "URL to the Wayback Machine's CDX API.")

(defparameter *web-url* "http://web.archive.org/web/"
  "URL to the Wayback Machine Web Archive.")

(defparameter *story-url* "fanfiction.net/read.php?storyid=*"
  "Base URL for archived stories. Meant to be used with the CDX API.")
