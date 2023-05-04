(defsystem "chil"
  :author "Karl Hallsby <karl@hallsby.com>"
  :components ((:file "chil"))
  :in-order-to ((test-op (test-op "chil/tests"))))

(defsystem "chil/tests"
  :depends-on ("chil" "lisp-unit2")
  :components ((:file "tests/example")))
