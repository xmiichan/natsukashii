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

(asdf:defsystem "natsukashii"
  :name "natsukashii"
  :version "0.1"
  :class :package-inferred-system
  :author "Mii"
  :licence "AGPL-3.0-or-later"
  :description "Archive search tool for fanfiction.net"
  :serial t
  :depends-on (#:cl-ppcre
               #:str
               #:dexador
               #:usocket
               #:quri
               #:plump
               #:lquery
               #:lparallel)
  :components ((:module "src"
                :components
                ((:file "package")
                 (:file "config" :depends-on ("package"))
                 (:file "utils" :depends-on ("config"))
                 (:file "scraper-old" :depends-on ("utils"))
                 (:file "scraper-new" :depends-on ("utils"))))))
