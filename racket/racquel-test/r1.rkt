#lang racket/base
(require racket/class)
(require db)
(require racquel)
(require "initdb.rkt")

(define conn (initdb))
;; (display (query-rows conn "select * from items"))

(define item-base% (gen-data-class conn "items"))
(define item%
  (class item-base%
    (define/public (show)
      (format "~a: ~a" name count))
    ))

;; save new
;; (define i1 (new item%))
;; (set-field! name i1 "tickets")
;; (set-field! count i1 3)
;; (save-data-object conn i1)

;; ;; query
;; (select-data-objects
;;  conn item%
;;  (where (= (item% count) ?)) 1)
(display
 (select-data-objects
  conn item% "order by count desc limit 3"))



