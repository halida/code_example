(require db)

(define conn
  (sqlite3-connect #:database 'memory))

(query-exec
 conn
 "create temporary table the_numbers (n integer, d varchar(20))")
(query-exec conn
    "insert into the_numbers values (0, 'nothing')")
(query-exec conn
    "insert into the_numbers values (1, 'the loneliest number')")
(query-exec conn
    "insert into the_numbers values ($1, $2)"
    (+ 1 1)
    "company")


(define result (query conn "select n, d from the_numbers where n % 2 = 0"))

(query-rows conn "select n, d from the_numbers where n % 2 = 0")
;; return one column
(query-list conn "select d from the_numbers order by n")
;; return value
(query-value pgc "select count(*) from the_numbers")
;; return 0 or 1 value
(query-maybe-value pgc "select d from the_numbers where n = 5")

;; loop
(for ([(n d) (in-query pgc "select * from the_numbers where n < 4")])
     (printf "~a: ~a\n" n d))
(for/fold ([sum 0]) ([n (in-query pgc "select n from the_numbers")])
          (+ sum n))

;; prepare
(define get-less-than-pst
    (prepare pgc "select n from the_numbers where n < $1"))
(query-list pgc get-less-than-pst 1)
(query-list pgc (bind-prepared-statement get-less-than-pst '(2)))

(disconnect pgc)

;; struct row-result
(define rr (query conn "select n, d from the_numbers where n % 2 = 0"))
(row-result-header rr)
(row-result-rows rr)
