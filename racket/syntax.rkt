;; define while
(define-syntax while
  (syntax-rules ()
    ((while condition body ...)
     (let loop ()
       (if condition
           (begin body ... (loop))
           #f))
     )))

(define x 3)
(while (< x 10)
       (set! x (+ x 1))
       (printf "~a\n" x))


;; define for
(define-syntax for
  (syntax-rules ()
    ((for element in list body ...)
     (for-each (lambda (element)
                 body ...)
               list
               ))
    ))

(for i in '(a b c)
     (printf "? ~a\n" i))

;; define for with keyword
(define-syntax for
  (syntax-rules (in as)
    ((for element in list body ...)
     (map (lambda (element)
            body ...)
          list))
    ((for list as element body ...)
     (for element in list body ...))))

(for '(0 1 2 3 4) as i
     (print i))

;; debug
(expand '(for i in (list 1 2 3)
              (printf "~a " i)))

;; define raw
(define-syntax (abc x y z)
  )
(abc 1 2 3)
