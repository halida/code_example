#!/usr/bin/env python
#-*- coding:utf-8 -*-
"""
"""
import zmq, time, logging

ctx = zmq.Context()

oper = ctx.socket(zmq.REP)
oper.bind('tcp://127.0.0.1:8900')

# 处理op
while True:
    time.sleep(0.01)
    try:
        rc = oper.recv(zmq.NOBLOCK)            
    except zmq.ZMQError:
        # 处理完所有命令就跳出命令处理逻辑
        continue

    try:
        rc = rc.strip()
        if rc.startswith('set'):
            exec(rc[3:].strip())
            result = "setted"
        else:
            result = str(eval(rc))
        logging.debug('caculate: %s, result: %s',
                      rc, result)        
        # 为了防止错误命令搞挂服务器, 加上错误处理
    except Exception as e:
        result = str(e)
        
    oper.send(result)
                
