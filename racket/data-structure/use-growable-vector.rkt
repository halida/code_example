#lang racket

(require data/gvector)

(define (show-size gv)
  (displayln (format "size: ~a" (gvector-count gv)))
  )

(define (run)
  (define gv (make-gvector))

  (show-size gv)
  (for ([a (range 1 11)])
    (gvector-add! gv (+ a a)))
  (show-size gv)
  
  (define vs
    (string-join
     (for/list ([a gv]) (number->string a))
     ))
  (displayln (format "values: ~a" vs))

  (gvector-remove! gv 3)
  (show-size gv)
  )

(run)
