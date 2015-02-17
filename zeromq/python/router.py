#!/usr/bin/env python
#-*- coding:utf-8 -*-
"""
module: router
"""
import zmq, time

ctx = zmq.Context()

outer = ctx.socket(zmq.XREP)
outer.bind('tcp://127.0.0.1:8910')

inner = ctx.socket(zmq.XREQ)
inner.connect('tcp://127.0.0.1:8901')

while True:
    while True:
        # get request
        msgs = []
        try:
            msgs.append(outer.recv())
            while outer.getsockopt(zmq.RCVMORE):
                msgs.append(outer.recv())
        except:
            break
    
        # balance
        inner = inners[random.randint(0, len(self.inners)-1)]
        
        # post
        for i, msg in enumerate(msgs):
            if i < len(messages) - 1:
                inner.send(msg, zmq.SNDMORE)
            else:
                inner.send(msg)
    
    # same as above
    ....
