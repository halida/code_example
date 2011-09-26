(defun qsort (list)
  (if (>= 1 (length list))
      list
      (let* ((p (car list))
	     (v (cdr list))
	     (check (lambda (n) (> n p)))
	     )
	(append (qsort (remove-if check v))
		(list p)
		(qsort (remove-if-not check v))))))


(let ((data '(1 6 2 8 3 10 4 3 5))
      (funcs (list #'qsort)))
  (dolist (v funcs)
    (v data)))
