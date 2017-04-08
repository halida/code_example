;; (use 'http-server)

;; (define (rack-run server)
;;   todo
;;   )
(use spiffy regex)

(define (rack-run server)
  (define (handler continue)
    (let* ((response (server (current-request)))
           (code (car response))
           (body (cadr response))
           (headers '((content-type text/html)))
           )
      (send-response code: code body: body headers: headers)
      (continue)
      )
    )

  (vhost-map
   `(
     (,(glob->regexp "*") . ,handler)
     ))
  (start-server)
  )

