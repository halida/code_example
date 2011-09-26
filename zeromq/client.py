#!/usr/bin/env python
#-*- coding:utf-8 -*-
"""
module: echo_client
"""
import zmq, time

ctx = zmq.Context()

oper = ctx.socket(zmq.REQ)
oper.connect('tcp://127.0.0.1:8900')

while True:
    try:
        rc = raw_input("%> ")
    except:
        print "bye!"
        break
    oper.send(rc)
    print oper.recv()
    print 
    

    
