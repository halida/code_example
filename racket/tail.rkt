(define (test-tail n)
  (if (> n 0)
      (test-tail (- n 1))
      0))

(display (test-tail 100000000))
