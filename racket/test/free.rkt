(define a 12)

(define (work a)
  (if (< a 0)
      0
      (+ a (work (- a 1))))
  )

(struct document (author title content))
(define d1 (document "james" "work" "..."))
(document-author d1)





  

