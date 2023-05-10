(in-package :chil)

(defstruct (module
            (:constructor module (name &key (inputs '()) (outputs '()))))
  (name "" :type string)
  ;; FIXME: inputs/outputs should be set, not list. We want to prevent people
  ;; from using the same symbol in the input/output collections.
  ;; TODO: But we DO allow the same object to be present in both.
  (inputs '() :type list)
  (outputs '() :type list))
