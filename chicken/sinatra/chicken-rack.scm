;; chicken-rack
(use rack)

(define source-file (args 1))

(load source-file)

(rack-run default-server)
