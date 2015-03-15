(use irregex) ; irregex, the regular expression library, is one of the
     	      ; libraries included with CHICKEN.

(define (process-line line re rplc) 
  (irregex-replace/all re line rplc))

(define (quickrep re rplc) 
  (let ((line (read-line)))
    (if (not (eof-object? line))
        (begin 
          (display (process-line line re rplc))
          (newline)
          (quickrep re rplc)))))

;;; Does a lousy job of error checking!
(define (main args)
  (quickrep (irregex (car args)) (cadr args)))

