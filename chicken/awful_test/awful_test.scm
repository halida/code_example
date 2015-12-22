(use awful)
(use spiffy)
(use awful-postgresql)
(use awful-ssql)

(enable-ssql #t)
(enable-sxml #t)

(define-page (main-page-path)
  (lambda ()
    (ajax "greetings" 'greetings 'click
          (lambda ()
            '(b "Hello, awful!"))
          target: "greetings-reply")
    `((a (@ (href "#") (id "greetings"))
         "Hello, " ,($ 'person "world") "!")
      (div (@ (id "greetings-reply")))))
  use-ajax: #t)

(define-page "/reload"
  (lambda ()
    (reload-apps (awful-apps))
    "Reloaded"))

;; sxml
(define-page "/sxml1"
  (lambda ()
    `(html
      (body
       (div (@ (class "container")
               (style "background: #eee"))
            (h1 "hello")
            (p "this is a test")
            (p "page")
            )))))

;; database
(enable-db)
(db-credentials '((dbname . "test_dev")
                  (user . "test")
                  (password . "test")
                  (host . "localhost")))

($db-each `(users (where (> id 1)))
      (lambda (user)
        `(tr (td ,(user 'id))
             (td ,(user 'email))
             (td ,(user 'type))
             ))
      )

(define-page "/users"
  (lambda ()
    `(html
      (head)
      (body
       (div
        (@ (class "container"))
        (table
         (tr (td "ID") (td "Email") (td "Type"))
         ,(map (lambda (user)
                 `(tr (td ,(list-ref user 0))
                      (td ,(list-ref user 1))
                      (td ,(list-ref user 2))
                      ))
               ($db `(select (columns id email type) (from users))))
         )))) ; html
    ))

