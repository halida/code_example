(require-extension coops)

(define-class <box> () (x y))

(define-generic (move box x y))
(define-generic (position box))

(define-method (move (box <box>) (x) (y))
  (let ()
    (set! (slot-value box 'x) (+ x (slot-value box 'x)))
    (set! (slot-value box 'y) (+ y (slot-value box 'y)))
    ))

(define-method (position (box <box>))
  (printf "box position: (~A, ~A)", (slot-value box 'x) (slot-value box 'y)))

(define box1 (make <box> 'x 0 'y 1))
(move box1 1 2)
(position box1)


(set! (slot-value box1 'x) (+ 3 (slot-value box1 'x)))
(slot-value box1 'x)
