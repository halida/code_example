def hello():
    print "helloworld"


def fib(n):
    cdef int a, b, t
    a = 0
    b = 1
    while b < n:
        t = a
        a = b
        b += t
    return b
