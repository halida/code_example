#lang racket
(require data/gvector)

(provide app% window%
         input% text-input% h-layout% layout%
         list-widget% list-item%)

(define gobject%
  (class object%
    (super-new)
    ))

(define widget%
  (class gobject%
    (super-new)
    (init-field [app null])
    (define/public (children) null)
    (define/public (set-app new-app)
      (unless (eq? app new-app)
        (set! app new-app)
        (define children (send this children))
        (when children
          (for/list ([w children])
            (send w set-app app)))
        ))

    (define/public (trigger-event event)
      (send app handle-event this event))
    ))

(define window%
  (class widget%
    (super-new)
    (inherit-field app)
    (init-field [layout null])
    (define/override (children)
      (list layout))
    (define/public (set-layout new-layout)
      (send new-layout set-app app)
      (set! layout new-layout))
    ))

(define input%
  (class widget%
    (super-new)
    ))

(define text-input%
  (class input%
    (super-new)
    (init-field [text ""])
    (define/public (set-text new-text)
      (set! text new-text))
    (define/public (get-text) text)
    (define/public (clear)
      (set! text ""))
    ))

(define list-widget%
  (class widget%
    (super-new)
    (init-field [items (make-gvector)])
    (define/public (item-count)
      (gvector-count items))
    (define/public (add-item item)
      (gvector-add! items item))
    (define/public (get-item i)
      (gvector-ref items i))
    ))

(define list-item%
  (class gobject%
    (super-new)
    (init-field [text ""])
    (define/public (get-text) text)
    ))

(define layout%
  (class widget%
    (super-new)
    (inherit-field app)
    (define widgets (make-gvector))
    (define/public (add-widget widget)
      (send widget set-app app)
      (gvector-add! widgets widget)
      )
    (define/override (children)
      (gvector->list widgets))
    ))

(define h-layout%
  (class layout%
    (super-new)
    ))


(define app%
  (class object%
    (super-new)

    (init-field [linked-events (make-hash)])
    (define/public (link-event widget event handler)
      (define key (list widget event))
      (define handlers (hash-ref! linked-events key make-gvector))
      (gvector-add! handlers handler)
      )
    (define/public (handle-event widget event)
      (define key (list widget event))
      (define handlers (hash-ref linked-events key null))
      (when handlers
        (for/gvector
         ([handler handlers])
         (handler event))))

    (define/public (add-window win)
      (send win set-app this))

    (define/public (run) null)
    (define/public (exit) null)
    ))

