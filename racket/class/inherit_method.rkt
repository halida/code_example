(define people%
  (class object%
    (super-new)
    (init-field age)
    (define/public (new-year)
      (set! age (add1 age)))
    ))

(define worker%
  (class people%
    (super-new)
    (init-field salary [money 0])
    (define/public (salary-year)
      (send this new-year)
      (set! money (+ money salary)))
    (define/public (get-money) money)
    ))

(define james (new worker% (age 31) (salary 3000)))
(send james get-money)
(send james salary-year)
(send james get-money)
