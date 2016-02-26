#lang racket/base
(require racket/class)
(require db)
(require racquel)

(define conn (sqlite3-connect #:database 'memory))
(query-exec conn "create table items (id integer primary key AUTOINCREMENT, name varchar(20), count integer)")
(for ([i 10])
  (query-exec conn "insert into items(name, count) values($1, $2)" (format "User ~a" i) i))

(define base-item%
  (gen-data-class
   conn "items"
    (define/public (show)
      (format "~a: ~a" name count))
   ))
(define item%
  (class (gen-data-class conn "items")
    (super-new)
    (inherit-field name count)
    (define/public (show)
      (format "~a: ~a" name count))
    ))

(select-data-objects
 conn base-item% "order by count desc limit 3")

(for ([item (select-data-objects
             conn item% "order by count desc limit 3")])
  (send item show))

