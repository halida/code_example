#!/usr/bin/env python
#-*- coding:utf-8 -*-
"""
module: puber
"""
import zmq, time

ctx = zmq.Context()

oper = ctx.socket(zmq.PUB)
oper.bind('ipc:///tmp/puber.ipc')

while True:
    time.sleep(1)
    oper.send(time.ctime())

