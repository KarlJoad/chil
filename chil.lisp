(defpackage :chil
  (:use :cl)
  (:export #:hello))

(in-package :chil)

(defstruct (module
            (:constructor module (name &key (inputs '()) (outputs '()))))
  (name "" :type string)
  ;; FIXME: inputs/outputs should be set, not list. We want to prevent people
  ;; from using the same symbol in the input/output collections.
  ;; TODO: But we DO allow the same object to be present in both.
  (inputs '() :type list)
  (outputs '() :type list))

(defun generate-verilog-module-args (direction args)
  "Generate Verilog argument string based on ARGS, noting the DIRECTION of the
arguments in the string as well.

The two directions supported are the symbols 'input and 'output."
  (defun arg->string (arg)
    (format nil "~a type ~a,~&" (string-downcase (symbol-name direction)) arg))

  (uiop:reduce/strcat
   (mapcar #'arg->string args)))

(defun generate-verilog (module)
  "Generate the Verilog corresponding to the provided Chil MODULE."
  (uiop:strcat
   (format nil "module ~a" (module-name module))
   (format nil "(~&")
   (generate-module-args 'input (module-inputs module))
   (generate-module-args 'output (module-outputs module))
   (format nil ")~&")
   ;; TODO: Get indentation working
   (format nil "body;~&")
   (format nil "endmodule // ~a" (module-name module))))

(defun hello ()
  (print "Hello world, from CHIL."))
