#!/usr/bin/env python
#-*- coding:utf-8 -*-
"""
module: tester
"""
import socket
import sys, timeit,

def job():
    HOST = 'localhost'    # The remote host
    PORT = 50007              # The same port as used by the server

    res = socket.getaddrinfo(HOST, PORT, socket.AF_UNSPEC, socket.SOCK_STREAM)
    af, socktype, proto, canonname, sa = res[0]
    s = socket.socket(af, socktype, proto)
    s.connect(sa)
    
    s.send('Hello, world')
    data = s.recv(1024)
    s.close()

def process():


n = 10000
print "check %d loop: %s" %(n, timeit.timeit(job, number= n))

print "check %d thread: %s" %(n, timeit.timeit(job_process, number= n))
