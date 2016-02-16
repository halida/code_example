;; read file and sort items

(define (generate-file)
  (write-file
   "aaa.txt"
   (string-join
    (times 10 generate-random-string)
    "\n")))

(define (write-file filename data)
  (let ((file (file-open "/tmp/hen.txt" (+ open/wronly open/append open/creat))))
    (file-write file data)
    ))

(define (times t f)
  (if (<= t 0) '()
      (cons
       (f)
       (times (sub1 t) f))
      ))
            
(define generate-random-string
  todo)
