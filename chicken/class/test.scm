;; this is a class system

(make-class 'number (value))
(map '(+ - * /)
     (lambda (op)
       (make-class-method
        number (op self v)
        (op (self 'value)
           (v 'value)
           ))
       ))

(define a (number 13))
(define b (number 12))
(define c (number 3))
((a + b) * c) ; 25
