(defsystem :chil
  :author "Karl Hallsby <karl@hallsby.com>"
  :description "Constructing Hardware In Lisp"
  :pathname #p"source/"
  :components ((:file "chil")
               (:module "Module"
                :pathname ""
                :depends-on ("chil")
                :components ((:file "module")))
               (:module "Backends"
                :pathname #p"backends/"
                :depends-on ("Module")
                :components ((:file "base")
                             (:file "verilog")
                             (:file "vhdl")
                             (:file "system-verilog")))
               (:module "Utils"
                :pathname ""
                :depends-on ()
                :components ((:file "utils")))
               (:module "Types"
                :pathname "types/"
                :depends-on ("Utils")
                :components ((:file "data")
                             (:file "uint"))))
  :in-order-to ((test-op (test-op "chil/tests"))))

(defsystem :chil/tests
  :depends-on (:chil :alexandria :lisp-unit2)
  :pathname #p"tests/"
  :components ((:file "example")
               (:file "write-verilog")
               (:file "utils")))

(defmethod asdf:perform ((o asdf:test-op) (c (eql (find-system :chil))))
  ;; ASDF produces this warning
  ;;WARNING:
  ;; Deprecated recursive use of (ASDF/OPERATE:OPERATE 'ASDF/LISP-ACTION:LOAD-OP
  ;; '("chil/tests")) while visiting (ASDF/LISP-ACTION:TEST-OP "chil") - please
  ;; use proper dependencies instead
  ;; This occurs because I invoke ASDF's operate inside another call to asdf:operate
  ;; See https://gitlab.common-lisp.net/asdf/asdf/-/issues/13 for how to fix
  (asdf:oos 'asdf:load-op :chil/tests)
  (let ((*package* (find-package :chil/tests)))
    (eval (read-from-string "
            (lisp-unit2:with-summary ()
             (lisp-unit2:run-tests
              :package :chil/tests
              :name :chil
              :run-contexts #'lisp-unit2:with-summary-context))
      "))))
