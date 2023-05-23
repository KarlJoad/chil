(in-package :chil)


;;; Abstract HDL generator class
(defclass hdl-generator ()
  ())

(defgeneric generate (generator module stream)
  (:documentation "Abstract method to generate the provided CHIL MODULE as another HDL."))


;;; Verilog Generator
(defclass verilog-generator (hdl-generator)
  ())

(defmethod generate ((generator verilog-generator) module stream)
  "Generate Verilog for the provided MODULE."

  (defun module-args (direction args)
    "Generate Verilog argument string based on ARGS, noting the DIRECTION of the
arguments in the string as well.

The two directions supported are the symbols 'input and 'output."
    (defun arg->string (arg)
      (format stream "~a type ~a,~&" (string-downcase (symbol-name direction)) arg))

    (uiop:reduce/strcat
     (mapcar #'arg->string args)))

  (uiop:strcat
   (format stream "module ~a" (chil:module-name module))
   (format stream "(~&")
   (module-args 'input (chil:module-inputs module))
   (module-args 'output (chil:module-outputs module))
   (format stream ")~&")
   ;; TODO: Actually write a real body
   ;; TODO: Get indentation working
   (format stream "body;~&")
   (format stream "endmodule // ~a" (chil:module-name module))))


;;; SystemVerilog Generator
(defclass systemverilog-generator (hdl-generator)
  ())

(defmethod generate ((generator systemverilog-generator) module stream)
  "Generate SystemVerilog for the provided MODULE.")


;;; VHDL Generator
(defclass vhdl-generator (hdl-generator)
  ())

(defmethod generate ((generator vhdl-generator) module stream)
  "Generate VHDL for the provided MODULE."
  ())
