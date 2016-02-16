;; qt like ui

(define ui-data
  (quote-all
   (widget
    (property 'height 600 'width 1024)
    (h-layout
     (widget)
     (widget)
     (v-layout
      (button (property 'text "left"))
      (button (property 'text "right"))
      )
     (widget)))
   ))

(define-class <BoardUI> (<widget>))
(define-method (initialize-instance (self <widget>))
  (init-ui ui-data)
  (link-socket)
  (set! (slot-value self 'game) (make <game>))
  )
(define-method (onKeyLeft (self <BoardUI>))
  (move (slot-value 'game) 'left)
  )
(define-method (onKeyright (self <BoardUI>))
  (move (slot-value 'game) 'right)
  )
  

(define app
  )

(run app)
