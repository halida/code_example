(defclass account ()
  ((customer-name
    :initarg :name
    :accessor customer-name)
   (balance
    :initarg :balance
    :initform 0
    :accessor balance)
   ))

(defparameter *a* (make-instance 'account :name "halida"))

(customer-name *a*)



 