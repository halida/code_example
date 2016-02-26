#lang racket

(define people%
  (class object%
    (super-new)
    (init-field firstname [lastname ""])
    ))

(define people (new people% [firstname "James"]))
(get-field firstname people)
(set-field! firstname people "Bob")


(define get-firstname (class-field-accessor people% firstname))
(get-firstname people)
(define set-firstname (class-field-mutator people% firstname))
(set-firstname people "Steven")

