(define (class-new classname . args)
  (lambda (method . args)
    (apply (get-method method) args)
    ))


(define-class 'post
  (lambda ()
    (attr 'title)
    (attr 'body)

    (define (content self)
      (append (self 'title) "\n" (self 'body))
      )
    ))

(define p1 (class-new 'post))
(p1 'set-title "hello")
(p1 'set-body "haha")
(p1 'title)
(p1 'content)


