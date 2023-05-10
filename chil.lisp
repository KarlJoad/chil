(defpackage :chil
  (:use :cl)
  (:export #:hello
           #:module
           #:module-name
           #:module-inputs
           #:module-outputs))

(in-package :chil)

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

(defun write-out-module-verilog (module &optional file-name)
  "Generate the lower-level representation of MODULE and write to disk.

You may optionally provide a name for the generated file. By default, this file
is named \"module-name.v\"."
  (with-open-file (out file-name
                       :direction :output
                       :if-exists :supersede
                       :if-does-not-exist :create)
    (write-string (generate-verilog module) out)))

(defun hello ()
  (print "Hello world, from CHIL."))
