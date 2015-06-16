(require-extension list-of)

(require-extension combinatorics)

(ordered-subset-map (lambda (x) x) '(1 2 3))

(define (same)
  (let ((n 4))
    (define (valid? l)
      (define (indexs)
        (add
         (permu (+ j (* n i)))
         (permu (+ i (* n j)))
         (permu (* i i))
         (permu ())
         ))
      (define (eq-16? v) (eq? v (* n n)))
      (any? (map eq-16? (map sum (map get-value indexs))))
      )
    
    (car (filter valid? (ordered-subset-map (lambda (x) x) (range 1 16))))
    ))

(define (main args)
  (same))
