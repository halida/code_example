;; reverse words in seq.

(defun rev (str)
  (reverse (rev-word str))
  )

(defun find-end (str start)
  "find end of char"
  (do ((x start (1+ x)))
      ((>= x (length str)) x)
    (if (find (aref str x)
	      "abcdefghizklmnopqrstuvwxyz")
	()
	(return x))))


(defun rev-word (str)
  (do* ((start 0 (+ end 1))
	(end (find-end str start)
	     (find-end str (+ end 1)))
       )
       ((>= start (length str)) str)
    (setf (subseq str start end)
	  (reverse (subseq str start end)))
    ))

(rev "you are a dog")
;; => "uoy era a god"


