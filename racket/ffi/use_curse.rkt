#lang racket/base
(require ffi/unsafe
         ffi/unsafe/define)
 
(define-ffi-definer define-curses (ffi-lib "libcurses"))

(define _WINDOW-pointer (_cpointer 'WINDOW))
 
(define-curses initscr (_fun -> _WINDOW-pointer))
(define-curses waddstr (_fun _WINDOW-pointer _string -> _int))
(define-curses wrefresh (_fun _WINDOW-pointer -> _int))
(define-curses endwin (_fun -> _int))

(define win (initscr))
;; (void (waddstr win "Hello"))
;; (void (wrefresh win))
;; (sleep 1)


(define _mmask_t _ulong)
(define-curses mousemask (_fun _mmask_t (o : (_ptr o _mmask_t))
                               -> (r : _mmask_t)
                               -> (values o r)))
(define BUTTON1_CLICKED 4)
 
(define-values (old supported) (mousemask BUTTON1_CLICKED))

(define-cstruct _MEVENT ([id _short]
                         [x _int]
                         [y _int]
                         [z _int]
                         [bstate _mmask_t]))


(define-curses getmouse (_fun (m : (_ptr o _MEVENT))
                              -> (r : _int)
                              -> (and (zero? r) m)))
 
;; (waddstr win (format "click me fast..."))
;; (wrefresh win)
;; (sleep 1)
 
;; (define m (getmouse))
;; (when m
;;   (waddstr win (format "at ~a,~a"
;;                        (MEVENT-x m)
;;                        (MEVENT-y m)))
;;   (wrefresh win)
;;   (sleep 1))

(define SIZE 256)
(define buffer (malloc 'raw SIZE))
(memset buffer 0 SIZE)
 
(void (wgetnstr win buffer (sub1 SIZE)))

 
(endwin)
