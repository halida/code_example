#lang racket

(define fish%
  (class object%
         (init size)
         (define current-size size)
         (super-new)

         (define/public (get-size)
           current-size)
         (define/public (grow amt)
           (set! current-size (+ amt current-size)))
         (define/public (eat other-fish)
           (grow (send other-fish get-size)))
         ))

(define charlie (new fish% [size 10]))

(send charlie grow 6)
(send charlie get-size)
;; => 16

(define hungry-fish%
  (class fish%
         (super-new)
         (inherit eat)
         (define/public (eat-more fish1 fish2)
           (send this eat fish1)
           (eat fish2))
         ))

;; 不用send这种动态查找的方法
(define get-fish-size (generic fish% get-size))
(send-generic charlie get-fish-size)


;; override
(define picky-fish%
  (class fish% (super-new)
         (define/override (grow amt)
           (super grow (* 3/4 amt)))
         ))


;; init
(define size-10-fish%
  (class fish%
         (super-new [size 10])
         ))

;; 设置初始化参数的值
(define default-10-fish%
  (class fish%
         (init [size 10])
         (super-new [size size])
         ))

;; interface
(define fish-interface
  (interface ()
             get-size grow eat
             ))
(define fish%
  (class* object%
          (fish-interface)
          ))
