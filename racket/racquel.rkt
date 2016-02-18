;; https://pkg-build.racket-lang.org/doc/racquel/index.html?q=racquel
(require racquel)
(require db)

(define conn (sqlite3-connect #:database 'memory))
(define (exec sql . arguments)
  (apply query-exec (append (list conn sql) arguments)))

(exec "create table items (id integer primary key AUTOINCREMENT, name varchar(20), count integer)")
(for ([i 10])
     (exec "insert into items(name, count) values($1, $2)" (format "User ~a" i) i)
     )
(query-exec conn "insert into items(name, count) values($1, $2)" "jj" 32)
(query-rows conn "select * from items")

(define item% (gen-data-class conn "items"))
;; (define item%
;;   (data-class object%
;;               (table-name "items")
;;               (column (id #f "id")
;;                       (name #f "name")
;;                       (count 0 "count"))
;;               (primary-key id)
;;               (define/public (desc)
;;                 (format "item for ~a is ~a" name count))
;;               (super-new)))


;; save new
(define i1 (new item%))
(set-field! name i1 "tickets")
(set-field! count i1 3)
(save-data-object conn i1)

;; query
(select-data-objects conn item%
                     (where (= (item% count) ?)) 1)
(select-data-objects conn item%
                     (limit 3))


