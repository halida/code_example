(define people%
  (class object%
    (init-field name)
    (super-new)

    (define/public (get-name)
      name
      )
    (define/public (set-name new-name)
      (set! name new-name)
      )
    ))

(define james (new people% [name "james"]))
(send james get-name)
(send james set-name "James")
(send james get-name)


