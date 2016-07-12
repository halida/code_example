#lang racket/base
(require racket/class)

(provide record%
         make-model query-model create-model
         )

(define conn null)
(define (orm-set-default-connection connection)
  (set! conn connection))
(define (orm-get-default-connection)
  conn)


(define (insert-sql table columns values)
  (define sql
    (format "insert into ~a(~a) values(~a)"
            table (string-join columns ", ")
            (string-join (for/list ([_ columns]) "?") ", ")
            ))
  (apply query-exec (append (list conn sql) values))
  (query-value conn "select id from items order by id desc limit 1")
  )
(define (update-sql table columns id values)
  (define sql
    (format "update ~a set ~a where id = ?"
            table (string-join (for/list ([c columns])
                                 (format "~a = ?" c))
                               ", ")
            ))
  (apply query-exec (append (list conn sql) values (list id)))
  )

(define record%
  (class object%
    (super-new)
    (init-field [table null])
    (init-field [id null])

    ;; init columns
    (define attrs
      (for/list ([row (query-rows conn (format "PRAGMA table_info('~a')" table))])
        (cons (list-ref row 1) (list-ref row 2)))
    (for ([row rows])
      (init-field (list-ref row 1)))

    (define/public (save)
      (define columns
        (for/list ([attr attrs])
          (car attr)))
      (define values
        (for/list ([column columns])
          (dynamic-get-field column this)))
      (if id
          (update-sql table columns values)
          (set! id (insert-sql table columns id values))
          ))
    )))

(define (make-model-proc %)
  (values create-model query-model)
  )

(define-syntax-rule (make-model table-name body ...)
  (class record%
    (super-new)
    body ...)
  )

(define-syntax-rule (create-model klass attrs ...)
  (let ([object (new klass attrs ...)])
    (send object save)
    object))

(define (query-model klass)
  (define table-name (get-table-for klass))
  (lambda args
    (define rows (query-rows conn (format "select ~a from ~a where ~a"
                                          columns table-name condition) values))
    (for/list ([row rows])
      (let ([object (new klass)])
        (for ([column columns] [value row])
          (set-field! column object value))))
    ))


(define (query->list query) query)
