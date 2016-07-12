#lang racket/base

(require "initdb.rkt")
(require "orm.rkt")

(define conn (initdb))
(orm-set-default-connection conn)

(make-model
 item
 (define/public (show)
   (format "~a:~a"
           (get-field name item)
           (get-field count item)
           ))
 )

(define i1
  (create-item [name "book"] [count 12]))

(set-field! count i1 1)
(send i1 save)

(define items (query-item "count > ?" 3))

(for/list ([item (query->list items)])
  (display (send item show)))

