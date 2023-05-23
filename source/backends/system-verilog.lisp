(in-package :chil/backends)

;;; SystemVerilog Generator
(defclass systemverilog-generator (hdl-generator)
  ())

(defmethod generate ((generator systemverilog-generator) module stream)
  "Generate SystemVerilog for the provided MODULE.")
