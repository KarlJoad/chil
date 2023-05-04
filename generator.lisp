(in-package :chil)


;;; Abstract HDL generator class
(defclass hdl-generator ()
  ())

(defgeneric generate-module-args (generator direction args))

(defgeneric generate (generator module)
  (:documentation "Abstract method to generate the provided CHIL MODULE as another HDL."))


;;; Verilog Generator
(defclass verilog-generator (hdl-generator)
  ())

(defmethod generate-module-args ((generator verilog-generator) direction args)
  "Generate Verilog argument string based on ARGS, noting the DIRECTION of the
arguments in the string as well.

The two directions supported are the symbols 'input and 'output."
  (defun arg->string (arg)
    (format nil "~a type ~a,~&" (string-downcase (symbol-name direction)) arg))

  (uiop:reduce/strcat
   (mapcar #'arg->string args)))

(defmethod generate ((generator verilog-generator) module)
  "Generate Verilog for the provided MODULE."
  (uiop:strcat
   (format nil "module ~a" (chil:module-name module))
   (format nil "(~&")
   (generate-module-args generator 'input (chil:module-inputs module))
   (generate-module-args generator 'output (chil:module-outputs module))
   (format nil ")~&")
   ;; TODO: Actually write a real body
   ;; TODO: Get indentation working
   (format nil "body;~&")
   (format nil "endmodule // ~a" (chil:module-name module))))


;;; SystemVerilog Generator
(defclass systemverilog-generator (hdl-generator)
  ())

(defmethod generate ((generator systemverilog-generator) module)
  "Generate SystemVerilog for the provided MODULE.")

