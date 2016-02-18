#lang racket/base

(require rackunit "class.rkt")

;; without syntax
(define-class-raw 'post
  (lambda (klass)
    (define-method klass 'name
      (lambda (self)
        "post"))
    ))
(define p1 (class-new 'post))
(check-equal? (p1 'name) "post")


;; class
;; (define-class post
;;   (attr 'title)
;;   (attr 'body)

;;   (define (content self)
;;     (append (self 'title) "\n" (self 'body))
;;     )
;;   )

;; (define p1 (post-new))
;; (p1 'set-title "hello")
;; (p1 'set-body "haha")
;; (p1 'title)
;; (p1 'content)
