;;; Client pal-user.scm
(declare (uses pal-proc))
(let ((arg (car (command-line-arguments))))
  (display 
   (string-append arg 
                  (if (palindrome? arg) 
                      " is a palindrome\n"
                      " isn't a palindrome\n"))))

