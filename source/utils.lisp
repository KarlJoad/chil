(in-package :chil)

(defun log2up (val)
  "Compute the number of bits required to represent VAL in binary."
  (assert (and (integerp val)
               (not (minusp val))))
  (1+ (values (ceiling (log val 2)))))
