#lang racket/base

(require racket/class)
(require db)
(require racquel)

(define conn (sqlite3-connect #:database 'memory))
(query-exec conn "create table items (id integer primary key AUTOINCREMENT, name varchar(20), count integer)")
(query-exec conn "create table cases (id integer primary key AUTOINCREMENT)")
(query-exec conn "create table case_items (id integer primary key AUTOINCREMENT, case_id integer, item_id integer)")
(for ([i 10])
  (query-exec conn "insert into items(name, count) values($1, $2)" (format "Item-~a" i) i)
  )

;; racquel auto gen
(define item% (gen-data-class conn "items"))
(define case% (gen-data-class conn "cases"))
(for/list ([item (select-data-objects
             conn item% "order by count desc limit 3")])
  (get-field name item))

;; know expend
(syntax->datum (expand #'(when (eq? 1 2) 12)))
(syntax->datum (expand #'(gen-data-class conn "items")))

(define uitem%
  (class item%
    (super-new)
    (define/public (test) 'test)
    ))
(select-data-objects
 conn item% "order by count desc limit 3")


;; override
(define item% (gen-data-class conn "items" 12))
(define uitem%
  (class item%
    (super-new)
    ;; (inherit-field name count)
    ;; (define/public (show)
    ;;   (format "~a: ~a" name count))
    ))
(for/list ([item (select-data-objects
             conn item% "order by count desc limit 3")])
  (send item show))

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

