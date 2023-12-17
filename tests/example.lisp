(defpackage :chil/tests
  (:use :cl :lisp-unit2 :check-it))

(in-package :chil/tests)

(define-test example ()
  (assert-eql 1 (- 2 1)))

;; The test below will always be correct, because the guard prevents odd numbers
;; from being generated as an input to the lambda.
(define-test check-it-example ()
  (assert-true
   (check-it:check-it (check-it:generator (check-it:guard #'evenp (integer)))
                      (lambda (x) (evenp x)))))
