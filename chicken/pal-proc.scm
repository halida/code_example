;;; Library pal-proc.scm
(declare (unit pal-proc))
(define (palindrome? x)
  (define (check left right)
    (if (>= left right)
        #t
        (and (char=? (string-ref x left) (string-ref x right))
             (check (add1 left) (sub1 right)))))
  (check 0 (sub1 (string-length x))))

