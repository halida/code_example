;; count words?

(sort-words 
 (group-words
  (filter-empty
   (split-words
    (read-file)))))

(defun read-file ()
  (with-open-file (in "wc.lisp")
    (read in)))

(read-file)