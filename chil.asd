(defsystem "chil"
  :author "Karl Hallsby <karl@hallsby.com>"
  :description "Constructing Hardware In Lisp"
  :pathname #p"source/"
  :components ((:file "chil")
               (:file "module")
               (:file "generator" :depends-on ("module")))
  :in-order-to ((test-op (test-op "chil/tests"))))

(defsystem "chil/tests"
  :depends-on ("chil" "alexandria" "lisp-unit2")
  :pathname #p"tests/"
  :components ((:file "example")
               (:file "write-verilog")))
