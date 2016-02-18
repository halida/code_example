#lang racket

(require (planet dmac/spin))
(require web-server/templates)
(require xml)

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

(get "/render-html"
     (lambda (req)
       (xexpr->string
        `(html
          (head (title "My Blog"))
          (body (h1 "Under construction")))
        )))

;; default 8000
(run)
