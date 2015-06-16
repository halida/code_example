(define (primes n l)
  (if (inl)
      (primes (+ n 1) l)
      (primes (+ n 1) (cons n l))
  ))
(primes)

(define (prime-bigger n)
  (select-first (lambda (p) (> p n))
                (primes)))

(define (main args)
  (let ((n 10000) (v (prime-bigger n)))
    (display "prime > ", n, " is: ", v)))
