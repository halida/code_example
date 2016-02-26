#lang racket
(require "gui.rkt")

(define (main)
  (define app (new app%))
  (define win (new window%))

  (define lo:main (new h-layout%))
  (define ti:input (new text-input%))
  (define lw:result (new list-widget%))

  (send lo:main add-widget ti:input)
  (send lo:main add-widget lw:result)
  (send win set-layout lo:main)
  (send app add-window win)

  (get-field app lo:main)

  (send app link-event
        ti:input 'return
        (lambda (e)
          (define text (send ti:input get-text))
          (define li:text (new list-item% [text text]))
          (send lw:result add-item li:text)
          (send ti:input clear)
          (display (format "items: ~a\n" (send lw:result item-count))
          )))

  (send app run)

  (send ti:input set-text "test")
  (send ti:input trigger-event 'return)

  (define first-item (send lw:result get-item 0))
  (display (format "first item: ~a\n" (send first-item get-text)))

  (send app exit)
  )

(main)


