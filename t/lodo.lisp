(in-package :cl-user)
(defpackage docset-generator-test
  (:use :cl
        :docset-generator
        :prove))
(in-package :docset-generator-test)

;; NOTE: To run this test file, execute `(asdf:test-system :docset-generator)' in your Lisp.

(setf *enable-colors* nil)

(defun test-dir ()
  (namestring
   (merge-pathnames
    "t/tmp"
    (asdf:component-pathname
     (asdf:find-system "cl-docset-generator")))))
   

(plan 4)

(subtest "make-docset test"
  (let ((docset (make-docset :id "foo"
			     :name "bar"
			     :family "baz")))
    (is (type-of docset) 'docset-generator::docset) 
    (is (slot-value docset 'docset-generator::id) "foo")
    (is (slot-value docset 'docset-generator::name) "bar")
    (is (slot-value docset 'docset-generator::family) "baz")
    (is (slot-value docset 'docset-generator::records) nil)
    (is (slot-value docset 'docset-generator::icon) nil)
    (is (slot-value docset 'docset-generator::base-dir) "/tmp")))

(subtest "make-record test"
  (let ((record (make-record :name "foo"
			     :type "bar"
			     :prefix "baz"
			     :body "blah")))
    (is (type-of record) 'docset-generator::docset-record)
    (is (slot-value record 'docset-generator::name) "foo")
    (is (slot-value record 'docset-generator::type) "bar")
    (is (slot-value record 'docset-generator::prefix) "baz")
    (is (slot-value record 'docset-generator::body) "blah")))

(subtest "add-record test"
  (let ((docset (make-docset))
	(record (make-record)))
    (add-record docset record)
    (is (type-of (car (slot-value docset 'docset-generator::records)))
	'docset-generator::docset-record)))

(subtest "generate test"
  (let ((docset (make-docset :id "foo"
			     :name "foo"
			     :family "foo"
			     :base-dir (test-dir))))
    (add-record docset
		(make-record :name "bar"
			     :type "Guide"
			     :prefix "foo"
			     :body "hello"))
    (pass (generate docset))))

(finalize)
