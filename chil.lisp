(defpackage :chil
  (:use :cl)
  (:export #:hello))

(in-package :chil)

(defun hello ()
  (print "Hello world, from CHIL."))
