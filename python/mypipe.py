#!/usr/bin/env python
#-*- coding:utf-8 -*-
"""
module: mypipe
"""
Pipe(range(12))\
    .take_while(lambda x: x > 12)\
    .select(lambda x: x*x)\
    . sum()

Pipe(range(12),
     take_while(lambda x: x > 12),
     select(lambda x: x*x),
     sum)

range(12) \
          | where(lambda x: x > 3) \
          | sum()


