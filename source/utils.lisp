(defpackage :chil/utils
  (:use :cl)
  (:export #:log2up))

(in-package :chil/utils)

(defun log2up (val)
  "Compute the number of bits required to represent VAL in binary."
  (assert (and (integerp val)
               (not (minusp val))))
  (1+ (values (ceiling (log val 2)))))
