(in-package :chil/tests)

(define-test log2up-of-zero ()
  (assert-equal 0 (chil:log2up 0)))

(define-test log2up-of-negative ()
  ;; This test SHOULD throw an error
  (assert-equal "module test-outputs(
output type addr,
output type valid,
)
body;
endmodule // test-outputs"
                (chil:log2up -1)))

(define-test log2up-normal ()
  (assert-equal 1 (chil:log2up 1))
  (assert-equal 2 (chil:log2up 2))
  (assert-equal 8 (chil:log2up 127))
  (assert-equal 8 (chil:log2up 128))
  (assert-equal 9 (chil:log2up 129)))
