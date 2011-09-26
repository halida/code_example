#!/usr/bin/env python
#-*- coding:utf-8 -*-
"""
module: xreq_test
"""
import zmq, time

# Prepare our context and sockets
context = zmq.Context()
frontend = context.socket(zmq.XREP)
frontend.bind("tcp://*:5559")

# Initialize poll set
poller = zmq.Poller()
poller.register(frontend, zmq.POLLIN)

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
while True:
    socks = dict(poller.poll(timeout=10))

    if socks.get(frontend) == zmq.POLLIN:
        messages = []
        messages.append(frontend.recv())        
        while frontend.getsockopt(zmq.RCVMORE):
            messages.append(frontend.recv())
        print "recived:", messages
        # buffer
        buffer.append(messages)

    if not clock.tick(block=False):
        continue
    
    # process
    for messages in buffer:
        print "sending:", messages
        messages[-1] += " is processed"
        for i, message in enumerate(messages):
            if i < len(messages) - 1:
                frontend.send(message, zmq.SNDMORE)
            else:
                frontend.send(message)
    buffer = []

