(defpackage :chil/sim
  (:use :cl :log4cl)
  (:export #:hello))

(in-package :chil/sim)

(defun hello ()
  (format t "Hello to Chil's Snapshotting Simulator!~&"))
