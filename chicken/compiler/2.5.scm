(define (empty-env) '()
  )
(define (apply-env env var)
  (if (eq? env empty-env)
      'none
      (let ((d (car env))
            (rest (cdr env)))
        (let (
              (dvar (car d))
              (dvalue (cdr d))
              )
          (if (eq? var dvar)
              dvalue
              (apply-env rest var)))))
  )

(define (extend-env var v env)
  (cons (cons var v) env)
)


(apply-env (extend-env
            'b 111
            (extend-env
             'a 12
             (empty-env))
            )
           'b)
