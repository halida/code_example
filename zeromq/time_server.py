#!/usr/bin/env python
#-*- coding:utf-8 -*-
"""
module: time_server
"""
import zmq, time

ctx = zmq.Context()

oper = ctx.socket(zmq.REQ)
oper.connect('tcp://127.0.0.1:8900')

puber = ctx.socket(zmq.PUB)
puber.bind('tcp://127.0.0.1:8901')

while True:
    time.sleep(1)
    oper.send("time.ctime()")
    result = oper.recv()
    puber.send(result)
    print "caculate time: ", result
    

    

