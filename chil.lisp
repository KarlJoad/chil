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

(defun hello ()
  (print "Hello world, from CHIL."))
