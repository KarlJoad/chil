(in-package :chil)

;; NOTE: Wrapping the symbol name in + is not done here (e.g. +ps+) because I
;; think having the bare symbol makes things easier to read.
(defconstant s 's "Seconds as a symbol evaluating to itself.")
(defconstant ms 'ms "Milliseconds as a symbol evaluating to itself.")
(defconstant us 'us "Microseconds as a symbol evaluating to itself.")
(defconstant ns 'ns "Nanoseconds as a symbol evaluating to itself.")
(defconstant ps 'ps "Picoseconds as a symbol evaluating to itself.")
(defconstant fs 'fs "Femtoseconds as a symbol evaluating to itself.")

(defparameter *valid-time-units* (list s ms us ns ps fs))

(defun valid-time-unitp (obj)
  "Verify if provided OBJ uses a valid time unit."
  (member obj *valid-time-units*))

(defstruct (module
            (:constructor module (name &key (inputs '()) (outputs '()))))
  (name "" :type string)
  ;; FIXME: inputs/outputs should be set, not list. We want to prevent people
  ;; from using the same symbol in the input/output collections.
  ;; TODO: But we DO allow the same object to be present in both.
  (inputs '() :type list)
  (outputs '() :type list))
