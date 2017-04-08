(load "sinatra.scm")

(get "/"
     (lambda (request)
       "hello"))
(get "/from/:id"
     (lambda (request)
       (sprintf "hello ~A" (request 'id))
       ))

(get "/page/:id"
     (lambda (request)
       (define sql '((from pages) (where (= id ,(request 'id)))))
       (define data ($query sql))
       (render "templates/page" ('data data))
       ))

;; run as: chicken-rack run.scm
