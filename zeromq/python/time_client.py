#!/usr/bin/env python
#-*- coding:utf-8 -*-
"""
module: time_client
"""
import zmq, time

ctx = zmq.Context()

suber = ctx.socket(zmq.SUB)
suber.setsockopt(zmq.SUBSCRIBE, '')
suber.connect('tcp://127.0.0.1:8901')

while True:
    print "get time: ", suber.recv()
 
