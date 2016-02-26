(require db)

(define conn
  (sqlite3-connect #:database 'memory))


(query-exec conn "create table items (id INTEGER PRIMARY KEY AUTOINCREMENT, name varchar, count integer)")
(query-exec conn
    "insert into items(name, count) values ($1, $2)" "cat" 3)

(define id 1)
(query-row conn "select name, count from items where id = $1" id)

;; js method
(define (model-item id)
  (match-define (vector name count)
    (query-row conn "select name, count from items where id = $1" id))
  (lambda (method . args)
    (case method
      ((name) name)
      ((set-name) (set! name (first args)))
      ((count) count)
      ((save) (query-exec conn "update items set name = $1, count = $2 where id = $3"
                          name count id))
      )))

(define i1 (model-item 1))
(i1 'name)
(i1 'set-name "v")
(i1 'name)
(i1 'save)


;; class method
(require racquel)
(define item% (gen-data-class conn "items"))
(define i2 (make-data-object conn item% 1))
(send i2 name)
