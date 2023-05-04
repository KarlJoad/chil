(in-package :chil/tests)

(defparameter *test-module-empty* (make-module-struct :name "test")
  "CHIL Module for testing that has no inputs, no outputs, and no body.")

(defparameter *test-module-inputs*
  (make-module-struct :name "test"
                      :inputs '("addr" "ready"))
  "CHIL Module for testing that has only inputs, no outputs, and no body.")

(defparameter *test-module-outputs*
  (make-module-struct :name "test"
                      :outputs '("addr" "valid"))
  "CHIL Module for testing that has only outputs, no inputs, and no body.")

(defparameter *test-module-inputs-outputs*
  (make-module-struct :name "test"
                      :inputs '("addr" "valid")
                      :outputs '("addr" "valid"))
  "CHIL Module for testing that has only outputs, no inputs, and no body.")

(define-test generate-verilog-empty-module ()
  (assert-eql "module test-empty(
)
body;
endmodule // test-empty"
              (generate-verilog *test-module-empty*)))

(define-test generate-verilog-module-only-inputs ()
  (assert-eql "module test-inputs(
input type addr,
input type ready,
)
body;
endmodule // test-inputs"
              (generate-verilog *test-module-inputs*)))

(define-test generate-verilog-module-only-outputs ()
  (assert-eql "module test-outputs(
output type addr,
output type valid,
)
body;
endmodule // test-outputs"
              (generate-verilog *test-module-outputs*)))

(define-test generate-verilog-module-inputs-outputs ()
  (assert-eql "module test-inputs-outputs(
input type addr,
input type valid,
output type addr,
output type valid,
)
body;
endmodule // test-inputs-outputs"
              (generate-verilog *test-module-inputs-outputs*)))
