#lang racket

(define people%
  (class object%
    (super-new)
    (define/public (name)
      'name)
    ))

(define get-name (generic people% name))
(define (run)
  (define p (new people%))
  (send-generic p get-name)
  )
(run)

(define get-name (make-generic people% 'name))
(send-generic p get-name)
(get-name p)

(define (r2)
  (define p (new people%))
  (define get-names (generic people% names))
  (send-generic p get-names)
  )
