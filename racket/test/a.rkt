#lang racket

(struct user (name email))

(define (user-email-domain user)
  (define email (user-email user))
  (list-ref (string-split email "@") 1)
  )


(define (run)
  (define u1 (user "James" "james@fs.com"))
  (user-email-domain u1)
  )
