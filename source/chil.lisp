(defpackage :chil
  (:use :cl)
  (:export #:hello
           #:module
           #:module-name
           #:module-inputs
           #:module-outputs
           #:generate
           #:verilog-generator
           #:log2up))

(in-package :chil)

(defun write-out-module-verilog (module &optional file-name)
  "Generate the lower-level representation of MODULE and write to disk.

You may optionally provide a name for the generated file. By default, this file
is named \"module-name.v\"."
  (with-open-file (out file-name
                       :direction :output
                       :if-exists :supersede
                       :if-does-not-exist :create)
    (write-string (generate (make-instance 'verilog-generator) module) out)))

(defun hello ()
  (let ((m (module "test"
                   :inputs '("addr" "ready")
                   :outputs '("data" "valid"))))
    (generate (make-instance 'verilog-generator) m)))
