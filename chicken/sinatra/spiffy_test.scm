(use spiffy)

;; (accept (lambda (request)
;;           (sprintf "hello")
;;           ))
(define (handler continue)
  (send-response code: 200 body: "<html><body>hello</body></html>" headers: '((content-type text/html)))
  (continue)
  )

(vhost-map
 `(
   ("localhost" . ,handler) ;; todo should handle all
   ))
 
(start-server)
