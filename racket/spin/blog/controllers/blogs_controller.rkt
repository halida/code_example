(define-controller 'blogs
  (lambda ()
    (define (index)
      (render 'index))
    (define (show)
      (define blog (blog-get (params 'id)))
      (render 'show))
    ))

