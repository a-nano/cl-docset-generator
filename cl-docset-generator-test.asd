#|
  This file is a part of lodo project.
|#

(defsystem cl-docset-generator-test
  :author "Masashi Iizuka <liquidz.uo@gmail.com>"
  :license "MIT"
  :depends-on (:cl-docset-generator
               :prove)
  :components ((:module "t"
                :components
                ((:test-file "lodo"))))
  :description "Test system for cl-docset-generator"

  :defsystem-depends-on (:prove-asdf)
  :perform (test-op :after (op c)
                    (funcall (intern #.(string :run-test-system) :prove-asdf) c)
                    (asdf:clear-system c)))
