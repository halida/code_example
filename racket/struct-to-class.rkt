#lang racket

(require data/gvector)

(define (struct-to-class s)
  )

(define gvector%
  (class object%
    (super-new)
    (define object (make-gvector))

    (define/public (ref index)
      (gvector-ref gv index))
    (define/public (add! value)
      (gvector-add! gv value))
    (define/public (set! index value)
      (gvector-set! gv index value))
    ))

(define (show-size gv)
  (displayln (format "size: ~a" (gv count)))
  )

(define (run)
  (define gv (make-gvector))
  (show-size gv)
  
  (for ([a (range 1 11)])
    (gv add! (+ a a)))
  (show-size gv)
  
  (define vs
    (string-join
     (for/list ([a gv]) (number->string a))
     ))
  (displayln (format "values: ~a" vs))

  (gv remove! 3)
  (show-size gv)
  )

(run)


