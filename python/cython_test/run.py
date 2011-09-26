#!/usr/bin/env python
#-*- coding:utf-8 -*-
"""
module: run
"""
import hello, timeit

def cfib():
    hello.fib(120000)

def pfib():
    fib(120000)

def fib(n):
    a, b = 0, 1
    while b < n:
        a, b = b, a+b
    return b

print timeit.timeit(cfib, number=300)
print timeit.timeit(pfib, number=300)
