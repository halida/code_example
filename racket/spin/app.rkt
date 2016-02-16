#lang racket

(require (planet dmac/spin))
(require web-server/templates)

(get "/"
     (lambda () "Hello!"))

(get "/hi"
     (lambda (req)
       (format "Hello, ~a!" (params req 'name))
       ))

(get "/template"
     (lambda (req)
       (define name (params req 'name))
       (include-template "index.html")))
(get "/headers"
     (lambda ()
       (define h (header #"Custom-Header" #"Itsy bitsy"))
       `(201 (,h) "Look for the custom header!")))

(run)
