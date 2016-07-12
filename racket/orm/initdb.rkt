#lang racket/base
(require db)

(provide initdb)

(define (initdb)
  (define conn (sqlite3-connect #:database 'memory))
  (query-exec conn "create table items (id integer primary key AUTOINCREMENT, name varchar(20), count integer)")
  (query-exec conn "create table cases (id integer primary key AUTOINCREMENT)")
  (query-exec conn "create table case_items (id integer primary key AUTOINCREMENT, case_id integer, item_id integer)")
  (for ([i 10])
    (query-exec conn "insert into items(name, count) values($1, $2)" (format "Item-~a" i) i))
  conn
  )
