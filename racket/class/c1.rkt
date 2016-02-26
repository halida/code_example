(define accessor<%>
  (interface () get set))

(define lock%
  (class* object% (accessor<%>)
    (super-new)
    (init-field [lock #f])
    (define/public (get) lock)
    (define/public (set new-lock) (set! lock new-lock))
    (define/public (look) "normal")
    ))

(define good-lock%
  (class lock%
    (super-new)
    (define/override (look)
      "looks good")
    ))

(define good-lock (new good-lock%))
(send good-lock get)
(send good-lock look)
(send good-lock look)

(define get (generic good-lock% get))


