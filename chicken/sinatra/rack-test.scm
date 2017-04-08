(load "rack.scm")

(define (server request)
  '(200 "<html><body>hello</body></html>")
  )

(rack-run server)

