(define people%
  (class object%
    (super-new)
    (init-field first-name [last-name null])
    (define/public (full-name)
      (if (eq? last-name null)
          first-name
          (format "~a ~a" first-name last-name)))
    ))

(define worker%
  (class people%
    (super-new)
    (init-field salary)
    (define/public (get-salary) salary)
    (define/public (show-salary)
      (format "~a has salary ~a" (send this full-name) salary))
    ))

(define p-james (new people% [first-name "James"]))
(send p-james full-name)
(define w-james (new worker% [first-name "james"] [salary 3000]))
(send w-james show-salary)

((class-field-accessor people% first-name) p-james)
((class-field-accessor worker% first-name) w-james)
