;; reverse string
(define (reverse-word string)
  (let ((data (string->list string)))
    (define (for-each-word f data)
      (define (for-each-word-inner f data is-word-now)
        (let ((c (car data)) (remain (cdr data)))
          todo)
        )
      (for-each-word-inner f data #f)
      )
    (define (reverse-words data)
      (for-each-word
       (lambda (word is-word)
         (if is-word
             (reverse word)
             word))
       data)
      )
    (list->string
     (reverse (reverse-words data)))
    ))


(string=?
 (reverse-word "please help me")
 "me help please")
