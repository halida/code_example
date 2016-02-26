#lang racket/base
(require "initdb.rkt")
(require "orm.rkt")

(define conn (initdb))

(define item%
  (generate-data-class conn "items"))

(define i1 (send item% find #:id 1))

(send i1 get-name)
(send i1 get-count)
(send i1 set-name "cat")
(send i1 save)

(send item% where "count > 10") ;; list

