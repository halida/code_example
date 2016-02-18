#lang racket/base

(require racket/dict)

(provide define-class-raw define-method class-new)

(define classes (make-hash))

(struct class-struct [attrs methods])
(struct object-struct [class attrs])

(define (define-class-raw class-name f)
  (define new-class (class-struct (make-vector 0) (make-hash)))
  (f new-class)
  (dict-set! classes class-name new-class)
  )

(define (define-method klass name f)
  (dict-set! (class-struct-methods klass) name f)
  )
(define (get-method object name)
  (define klass (object-struct-class object))
  (dict-ref (class-struct-methods klass) name)
  )

(define (class-new class-name)
  (define class (dict-ref classes class-name))
  (define new-object (object-struct class (make-vector 0)))
  (lambda (method-name . args)
    (apply (get-method new-object method-name) (cons new-object args)))
  )



;; todo
;; contact for define-method
