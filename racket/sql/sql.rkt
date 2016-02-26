(sql (create table items (name varchar count integer)))

(sql (insert into items (name count) values ("book" 100)))

(sql (select * from items where (> values 12) (order by values) (limit 10)))

(sql (select * from items where (> values $1)) 12)
(sql (select * from items where (> values :value)) #:value 12)


