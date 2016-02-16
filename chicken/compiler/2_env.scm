;; lambda
(define (empty-env)
  (lambda (i) '())
  )
(define (apply-env env var)
  (env var)
  )
(define (extend-env var v env)
  (lambda (i)
    (if (eq? i var)
        v
        (apply-env env var)))
  )

(apply-env (extend-env
            'b 111
            (extend-env
             'a 12
             (empty-env))
            )
           'b)


(define e
  (fold 
   (lambda (data env)
     (format #t "data: ~A env: ~A~N" data env)
     (extend-env (car data) (cdr data) env)
     )
   (empty-env)
   '((a 1) (b 3) (c 2))
   ))
(apply-env e 'b)

(reduce (lambda (a b) (cons a b))
        '()
        (list 1 2 3))

(apply-env e 'b)
