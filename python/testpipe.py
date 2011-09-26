#!/usr/bin/env python
#-*- coding:utf-8 -*-
"""
module: testpipe
"""
#from __future__ import print_function
from pipe import *

def primes():
    primes = []
    i = 2
    while True:
        for p in primes:
            if i % p == 0:
                break
        else:
            primes.append(i)
            yield i
        i += 1

result = primes() \
         | take(30) \
         | as_list

class MyPipe:
   def __init__(self, function):
       self.function = function

   @staticmethod
   def run(start, *args):
       result = start
       if len(args) > 0:
           for i in args:
               result = i.function(result)
       return result
           
   def __ror__(self, other):
       return self.function(other)
   
        
print MyPipe.run(primes(),
                 take(30),
                 as_list)

import timeit

def sum1():
    return sum([i for i in xrange(10000)
                if i % 2 == 0])

def sum2():
    return xrange(10000) | where(lambda x: x%2 == 0) | add

print "sum1:", timeit.timeit(sum1, number=1000)
print "sum2:", timeit.timeit(sum2, number=1000)
