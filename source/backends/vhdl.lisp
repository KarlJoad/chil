(in-package :chil/backends)

;;; VHDL Generator
(defclass vhdl-generator (hdl-generator)
  ())

(defmethod generate ((generator vhdl-generator) module stream)
  "Generate VHDL for the provided MODULE."
  ())
