(define (power x n)
  (cond
   ((eq? n 0) 1)
   ((eq? n 1) x)
   ((even? n) (power (* x x) (/ n 2)))
   (else (* x (power x (- n 1))))
   ))

(define (main args)
  (let ((x 3) (n 10))
    (format #t "power ~A of ~A = ~A" x n (power x n))
    ))

