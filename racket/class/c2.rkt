;; user - blog - post - comment
;; user: author, editor, commentor
;; post: references, changelog

(define model%
  (class object%
    (super-new)
    ))

(define user%
  (class model%
    (super-new)
    (init-field name email admin)
    (define/public (admin?)
      admin)
    ))

(define blog%
  (class model%
    (super-new)
    (init-field name user)
    ))

(define post%
  (class model%
    (super-new)
    (init-field title body blog)
    ))


;; testing
(define user-halida
  (new user%
       [name "halida"]
       [admin #t]
       [email "linjunhalida@gmail.com"]
       ))

(send user-halida admin?) ;; #t

(define blog-first
  (new blog%
       [name "first blog"]
       [user user-halida]
       ))

(define post-hello
  (new post%
       [title "hello"]
       [body "this is the first post"]
       [blog blog-first]
       ))

(send user-halida posts)
