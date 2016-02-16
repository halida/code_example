(define (invert lst)
  (if (eq? lst '())
      lst
      (cons (reverse (car lst))
            (invert (cdr lst)))))

(invert '((a 1) (a 2) (1 b) (2 b)))

