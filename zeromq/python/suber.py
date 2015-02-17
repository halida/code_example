#!/usr/bin/env python
#-*- coding:utf-8 -*-
"""
module: suber
"""
import zmq, time

ctx = zmq.Context()

oper = ctx.socket(zmq.SUB)
oper.connect('ipc:///tmp/puber.ipc')

while True:
    print oper.recv()


