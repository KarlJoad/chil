;;; CHIL --- Constructing Hardware in Lisp
;;; Copyright © 2023 Karl Hallsby <karl@hallsby.com>
;;;
;;; This file is part of CHIL.
;;;
;;; CHIL is free software; you can redistribute it and/or modify it
;;; under the terms of the GNU General Public License as published by
;;; the Free Software Foundation; either version 3 of the License, or
;;; (at your option) any later version.
;;;
;;; CHIL is distributed in the hope that it will be useful, but
;;; WITHOUT ANY WARRANTY; without even the implied warranty of
;;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
;;; General Public License for more details.
;;;
;;; You should have received a copy of the GNU General Public License
;;; along with CHIL.  If not, see <http://www.gnu.org/licenses/>.

;;; Commentary:
;;
;; GNU Guix development package.  To build and install, run:
;;
;;   guix package -f guix.scm
;;
;; To use as the basis for a development environment, run:
;;
;;   guix shell -D -f guix.scm
;;
;;; Code:

(use-modules (ice-9 popen) ;; These first packages are needed to build guix.scm description
             (ice-9 rdelim)
             ((guix build utils) #:select (with-directory-excursion))
             ;; Stuff to build the package
             (guix packages)
             (guix licenses)
             (guix utils)
             (guix gexp)
             (guix build-system asdf)
             (gnu packages)
             (gnu packages autotools)
             (gnu packages texinfo)
             (gnu packages lisp)
             (gnu packages lisp-xyz)
             (gnu packages lisp-check))

(define %srcdir
  (or (current-source-directory) "source"))

(define (git-version)
  (let* ((pipe (with-directory-excursion %srcdir
                 (open-pipe* OPEN_READ "git" "describe" "--always" "--tags")))
         (version (read-line pipe)))
    (close-pipe pipe)
    version))

(package
  (name "chil")
  (version (git-version))
  (source (local-file (dirname %srcdir) #:recursive? #t))
  (native-inputs
   (list autoconf automake texinfo ;; Building the manual
         cl-lisp-unit2
         cl-log4cl
         sbcl))
  (inputs
   (list cl-alexandria
         cl-slime-swank
         cl-slynk
         ;; cl-stmx ;; Transactional memory for simulator updates. https://stmx.org/features/
         ))
  (build-system asdf-build-system/sbcl)
  (arguments
     (list
      #:phases
      #~(modify-phases %standard-phases
          (add-after 'install 'install-manual
            (lambda* (#:key (configure-flags '()) (make-flags '()) outputs
                      #:allow-other-keys)
              (let* ((out  (assoc-ref outputs "out"))
                     (info (string-append out "/share/info")))
                (invoke "./bootstrap")
                (apply invoke "sh" "./configure" "SHELL=sh" configure-flags)
                (apply invoke "make" "info" make-flags)
                (install-file "doc/chil.info" info)))))))
  (synopsis "Constructing Hardware in Lisp")
  (description "CHIL (Constructing Hardware in Lisp)")
  (home-page "http://github.com/KarlJoad/chil")
  (license gpl3+))
