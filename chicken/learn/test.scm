;; lambda
(define (f x)
  (x 20))

(f (lambda (x) (* x x)))


(define (in-S? n)
  (if (zero? n) #t
      (if (>= (- n 3) 0) (in-S? (- n 3))
          #f)))

(in-S? 6)

;; let
(let ((a 12))
  (+ a 12))

;; regular expression
;; "abc" =~ /a*/
;; ('a' '*)
;; ([ab]+cde)
;; ((+ (or a b)) cde)

(define (reg string)
  )

;; fab
;; 1 1 2 3 5 ...

;; naive
(define (fib x)
  (if (<= x 2)
      1
      (+ (fab (- x 1))
         (fab (- x 2)))))

;; cache
(define (fib x)
  (define (fib-inner a b n)
    (if (= n 0)
        a
        (fib-inner b (+ a b) (- n 1)))
    )
  (fib-inner 0 1 x)
  )

;; loop
(loop 1 1000
      (lambda (x)
        (format #t "fib ~A = ~A~%" x (fib x))
        ))

(define (loop from to f)
  (f from)
  (if (= from to)
      #f
      (loop (+ from 1) to f)
      ))


(loop 1 10 (lambda (x)
             (format #t "Got ~A~%" x)
             ))
;; loop lib
(use srfi-1)
(import srfi-1)
(map (lambda(x) (* x x)) (iota 5 1))

;; hash table
(import srfi-69)
(define hash (make-hash-table))

;; object
(define (make-people args)
  (define (setter name value)
    todo)
  (define (getter name)
    todo)

  (define)
  )
(define p
  (make-people ('name "halida") ('age 12))
  )

(p 'get 'name) # => halida
(p 'set 'name "haha")
(p 'get 'name) # => "haha"

;; coops
(require-extension coops)
(require-extension coops-primitive-objects)

(define-class <human> () (name birthday children))
(define-class <male> (<human>) ())
(define-class <female> (<human>) ())

(define-generic (have-sex! a b))

(define-method (have-sex! (a <male>) (b <male>)) 'just-fun)
(define-method (have-sex! (a <female>) (b <female>)) 'just-fun)
(define-method (have-sex! (a <male>) (b <female>))
  (let ((newborn (make <human> 'name "Bobby")))
    (set! (slot-value a 'children) (cons newborn (slot-value a 'children)))
    (set! (slot-value b 'children) (cons newborn (slot-value b 'children)))
    newborn
  ))

(define bob (make <male> 'name "Bob"))
(define nancy (make <female> 'name "Nancy"))

(have-sex! bob nancy)
