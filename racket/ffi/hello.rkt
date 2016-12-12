#lang racket/base

(require "curses.rkt")

(displayln (curses-version))

;; (define (show-message message)
;;   (define width (+ 6 (string-length message)))
;;   (define win (init-window 5 width (- lines 5) ))
;;   (send win box ?| |-)
;;   (send win setpos 2 3)
;;   (send win addstr message)
;;   (send win refresh)
;;   (send win getch)
;;   (send win close)
;;   )

(define (run)
  (define win (initscr))
  (waddstr (format "Hit any key"))
  (wrefresh win)
  (sleep 1)
  ;; (show-message "hello, world!")
  (endwin)
  )

(run)
