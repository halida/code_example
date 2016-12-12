(struct ll-node (data next))
(struct ll-head (next tail))

(define (linked-list-new)
  (ll-head null null))

(define (linked-list-pushback ll data)
  (define node (ll-node data null))
  (define next (ll-head-next ll))
  (set-ll-node-next! next node)
  (ll-head next node)
  )

(define (linked-list-find ll key)
  (define (find-node node key)
    (define node-data (ll-node-data node))
    (define node-next (ll-node-next node))
    (if (eq? (car node-data) key)
        (cdr node-data)
        (if (null? node-next)
            null
            (find-node node-next key))))
  (define node (ll-head-next ll))
  (if (null? node)
      null
      (find-node node))
  )

(define (linked-list-index))
(define (lined-list-update))
(define (lined-list-delete))
(define (lined-list-insert))

(define (test)
  (define ll (linked-list-new))
  (linked-list-append ll '(a 12))
  (linked-list-append ll '(b 13))
  (linked-list-append ll '(c 13))
  (linked-list-find 'a)
  )


