#lang racket/base
(require db)

(provide initdb)

(define (initdb)
  (define conn (sqlite3-connect #:database 'memory))
  (query-exec conn "create table items (id integer primary key AUTOINCREMENT, name varchar(20), count integer)")
  (for ([i 10])
    (query-exec conn "insert into items(name, count) values($1, $2)" (format "User ~a" i) i))
  (query-exec conn "insert into items(name, count) values($1, $2)" "jj" 32)
  ;; (query-rows conn "select * from items")
  conn
  )
