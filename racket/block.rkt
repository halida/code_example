#lang racket

(defun (while f))

(defun (run)
  (map
   (range 1 12)
   (lambda (i)
     (* i i)
     ))
  )

(defun (run)
  ((range 1 12) map
   (lambda (i)
     (* i i)
     ))
