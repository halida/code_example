;;; fib-user.scm
#>
  extern int fib(int n);
<# 
(define xfib (foreign-lambda int "fib" int))
(do ((i 0 (+ i 1))) ((> i 10))
  (printf "~A " (xfib i)))
(newline)

