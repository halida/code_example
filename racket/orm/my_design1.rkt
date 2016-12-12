(define conn (make-connect sqlite3 :memory:))

(run-sql conn create table user (name string) (id integer) (login_at datetime))
(run-sql conn insert table user (name id) ("James" 12))
(run-sql conn insert table user (name id) ("Bob" 3))
(run-sql conn query user (name id) (= name "James"))

(run-sql conn insert into user (name id) values ("James" 12))
