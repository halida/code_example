;; (use 'rack)
(use spiffy)

(define (vector-push vector v)
  (vector-append vector #(v))
  )

(define (vector-find f vector)
  (call/cc
   (lambda (return)
     (map (lambda (i)
            (if (f (vector-ref vector i)) (return i))
            )
          (iota (vector-length vector)))
     )))
(define (vector-find-value f vector)
  (vector-ref vector (vector-find f vector))
  )

(define handlers (make-vector 0))

(define (register-handler request-method route handler)
  (make-matcher request-method route)
  (vector-push handlers '(matcher handler))
  )

(define (make-matcher request-method route)
  (lambda (request))
  (if (eq? (request 'method) request-method)
      (if (eq? (request 'path) route) #t)
  )

(define (get route handler)
  (register-handler 'get route handler))

(define (get-handler request)
  (let* (
         (item (vector-find-value
                (lambda (item)
                  ((car item) request)
                  )
                handlers))
         (handler (cadr item))
         ))
  handler
  )

(define (process-result result)
  (cond
   ((pair? result) todo)
   (else '(200 result))
   ))

(define (server)
  (lambda (request)
    (let* ((handler (get-handler request))
           (result (handler request))
           )
      (process-result result)
      )))

(rack-run (make-server config))
