(in-package :chil)


;;; Abstract HDL generator class
(defclass hdl-generator ()
  ())

(defgeneric generate-module-args (generator direction args))

(defgeneric generate (generator module)
  (:documentation "Abstract method to generate the provided CHIL MODULE as another HDL."))
