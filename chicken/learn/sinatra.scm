;; sinatra like
(define app
  (get "/"
       (set-variable 'name (get-params 'name))
       (render "root")
       )
  (get "/spaces/:id"
       (set-variable 'space (find <space> (get-params 'id)))
       (render "spaces/show"))
  )

(run app)
