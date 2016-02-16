(define (duple times data)
  (if (> 1 times)
      '()
      (cons data (duple (sub1 times) data))))

(duple 2 3)
;; (3 3)
(duple 4 '(ha ha))
