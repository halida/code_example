#!/usr/bin/env python
#-*- coding:utf-8 -*-
"""
module: marcotest
"""

# marco example
defmacro NAME(name):
    name

me = 12
print NAME(me) # me

# foreach
defmacro FOREACH(var, n):
    for var in range(`n)

for i in range(12):
    print i

FOREACH(i, 12):
    print i

def is():
    =
