#!/usr/bin/env python
#-*- coding:utf-8 -*-
"""
module: pipe_example
"""
from pipe import *

import datetime

@Pipe
def hour(hour):
    return datetime.timedelta(seconds=hour * 3600)

@Pipe
def ago(delta):
    return datetime.datetime.now() - delta

print (1 | hour | ago)
