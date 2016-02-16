;; prefix tree
(define data (list - - 3 2 4))

(list + 3 2 * 1 3 / 2 / 3 1)

(apply-prefix-list data) ;; => -3

(define (caculator? i)
  (or (eq? i '+) (eq? i '-) (eq? i '*) (eq? i '/))
  )

;; prefix-list:
;; prefix-item = int
;; prefix-combine = caculator prefix-list prefix-list
(define-datatype prefix-list prefix-list?
  (prefix-item (item number?))
  (prefix-combine (caculator caculator?)
                  (left prefix-list?)
                  (right prefix-list?))
  )

(define i
  (prefix-combine '+ (prefix-item 1) (prefix-item 12)))

(define (display-prefix-list data)
  (cases prefix-list data
         (prefix-item (item) item)
         (prefix-combine (caculator left right)
                         (list caculator
                               (display-prefix-list left)
                               (display-prefix-list right))))
  )

(display-prefix-list i)

