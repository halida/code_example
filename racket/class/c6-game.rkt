#lang racket
(require dyoo-while-loop)

(define sprite%
  (class object%
    (init-field name side atk hp)
    (super-new)
    (define/public (show)
      (format "#~a<~a> atk:~a hp:~a" side name atk hp)
      )
    (define/public (alive?)
      (> hp 0)
      )
    (define/public (hit atk)
      (set! hp (- hp atk))
      hp
      )
    ))

(define game%
  (class object%
    (define sprites null)
    (field [n-step 0])
    (super-new)

    (define/public (add sprite)
      (displayln (format "add sprite: ~a" (send sprite show)))
      (set! sprites (cons sprite sprites))
      )

    (define/public (run)
      (displayln "running")
      (displayln (format "sides: ~a" (all-alive-sides)))
      (while (< 1 (length (all-alive-sides)))
        (send this step))
      (displayln "result:")
      (for-each (lambda (sprite)
                  (displayln (send sprite show)))
                sprites)
      )

    (define/public (step)
      (set! n-step (+ n-step 1))
      (displayln (format "step: ~a" n-step))
      ; each alive sprite hit once
      (define atks (filter pair? (map get-atk sprites)))
      (map apply-atk atks)
      )

    (define (all-alive-sides)
      (remove-duplicates
       (map (lambda (sprite) (get-field side sprite))
            (filter (lambda (sprite) (send sprite alive?))
                    sprites)))
      )

    (define (get-atk sprite)
      (if (send sprite alive?)
          (list (get-field side sprite) (get-field atk sprite) sprite)
          null
          ))

    (define (apply-atk atk)
      ; (displayln (format "atk: ~a" atk))
      (define side (list-ref atk 0))
      (define atk-v (list-ref atk 1))
      (define hit-sprite (list-ref atk 2))

      (define other-side (remainder (+ side 1) 2))
      (define sprite (get-next-sprite-by-side other-side))
      (define new-hp (send sprite hit atk-v))
      
      (displayln (format "sprite: ~a hit by ~a, lost ~a, hp:~a"
                         (get-field name sprite)
                         (get-field name hit-sprite)
                         atk-v new-hp
                         ))
      (if (send sprite alive?)
          null
          (displayln (format "sprite: ~a dead."
                             (get-field name sprite)))
          )
      )

    (define (get-next-sprite-by-side side)
      (findf (lambda (sprite)
               (and (eq? side (get-field side sprite))
                    (send sprite alive?))
               )
             sprites)
      )

    ))

(define (run)
  (define game (new game%))
  (define npc1 (new sprite% [name "npc1"] [side 0] [atk 10] [hp 100]))
  (define wolf1 (new sprite% [name "wolf1"] [side 1] [atk 4] [hp 100]))
  (define wolf2 (new sprite% [name "wolf2"] [side 1] [atk 4] [hp 100]))

  (send game add npc1)
  (send game add wolf1)
  (send game add wolf2)
  (send game run)
  )

(run)
