(in-package :cl-user)

;; FIXME: Currently the chil: package cannot be found during image compilation
(sb-ext:save-lisp-and-die "chil" :toplevel (lambda ()
                                             (chil:hello)
                                             0)
                                 :executable t
                                 :purify t)
