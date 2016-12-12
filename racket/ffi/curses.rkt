#lang racket/base
(require ffi/unsafe
         ffi/unsafe/define)

(define-ffi-definer define-curses (ffi-lib "libcurses"))

(define (curses-version)
  "0.0.1")

(define _WINDOW-pointer (_cpointer 'WINDOW))

(define (check v who)
  (unless (zero? v)
    (error who "failed: ~a" v)))

(define-curses initscr (_fun -> _WINDOW-pointer))
(define-curses waddstr (_fun _WINDOW-pointer _string -> (r : _int)
                             -> (check r 'waddstr)))
(define-curses wrefresh (_fun _WINDOW-pointer -> (r : _int)
                              -> (check r 'wrefresh)))
(define-curses endwin (_fun -> (r : _int)
                            -> (check r 'endwin)))

(provide curses-version
         initscr
         waddstr
         wrefresh
         endwin
         )

