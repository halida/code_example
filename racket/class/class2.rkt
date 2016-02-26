;; test syntax
(define-syntax define-value
  (syntax-rules ()
    [(_ name value)
     (define name value)]))

(define-value 'a 2)

;; test with-syntax
(require (for-syntax racket/syntax))

(define-syntax (define-get stx)
  (syntax-case stx ()
    [(_ name)
     (with-syntax ([get (format-id stx "get-~a" #'name)])
       #'(define get 12))
     ]))
(define-get aa)

;; attr accessor
(define-syntax (define-accessor stx)
  (syntax-case stx ()
    [(_ name)
     (with-syntax ([get-name (format-id stx "get-~a" #'name)]
                   [set-name (format-id stx "set-~a" #'name)]
                   )
       #'(begin
           (define/public (get-name) name)
           (define/public (set-name new-name) (set! name new-name))
          )
       )]))

(define item%
  (class object%
    (init-field name count)
    (super-new)
    (define-accessor name)
    (define-accessor count)
    ))

(define i1 (new item% [name "cat"] [count 12]))
(send i1 get-name)
(send i1 set-count 32)
(send i1 get-count)


