#!/usr/bin/env python
#-*- coding:utf-8 -*-
"""
module: xreq_test2
"""
import zmq, time

# Prepare our context and sockets
context = zmq.Context()
frontend = context.socket(zmq.XREP)
frontend.bind("tcp://*:5559")

buffer = []

class Clock():
    "一个分时器，限制刷新率"
    def __init__(self, fps):
        self.fps = fps
        self.interval = 1.0/fps
        self.pre = time.time()

    def tick(self, block=True):
        now = time.time()
        mid = now - self.pre
        if  mid < self.interval:
            if block:
                time.sleep(self.interval - mid)
            else:
                return
        self.pre = time.time()
        return True

# Switch messages between sockets
clock = Clock(1)
messages = []
while True:

    try:
        message = frontend.recv(zmq.NOBLOCK)
        messages.append(message)
        if not frontend.getsockopt(zmq.RCVMORE):
            print "recived:", messages
            buffer.append(messages)
            messages = []
    except:
        time.sleep(0.1)

    if not clock.tick(block=False):
        continue
    
    # process
    for messages in buffer:
        messages[-1] += " is processed"
        print "sending:", messages
        for i, message in enumerate(messages):
            if i < len(messages) - 1:
                frontend.send(message, zmq.SNDMORE)
            else:
                frontend.send(message)
    buffer = []


