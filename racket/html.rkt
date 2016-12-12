(require xml)
(define data
  '(html
    (head
     (style ([type "text/css"])
       "body{background: red}"
       ))
    (body
     (h1 ([style "font-weight: bold"]) "Hello")
     (p "this is page 1")
     )))
(xexpr->string data)

(define html-data
  (with-output-to-string
    (lambda ()
      (define url "http://example.com/")
      (define cmd (format "wget -qO- ~a" url))
      (system cmd)
      )))
(string->xexpr html-data)


(define css
  '("h1.select"
    (background red)
    )
  )
