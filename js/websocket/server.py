#!/usr/bin/env python
#-*- coding:utf-8 -*-
"""
module: server
"""
import os, time, logging
import tornado.ioloop, tornado.web, tornado.websocket

class EchoWebSocket(tornado.websocket.WebSocketHandler):
    def open(self):
        pass
        #self.receive_message(self.on_message)

    def on_message(self, message):
       self.write_message(u"You said: " + message)

class ChatRoomWebSocket(tornado.websocket.WebSocketHandler):
    connects = []
    def open(self):
        self.connects.append(self)
        
    def on_message(self, message):
        if message.startswith('name: '):
            self.name = message[6:]
            self.broadcast(self.name + ' enters.')
            return
        self.broadcast(self.name + ' says: ' + message)

    def broadcast(self, msg):
        for c in self.connects:
            c.write_message(msg)
            
    def on_close(self):
        self.connects.remove(self)
        self.broadcast(self.name + ' leaves.')

settings = {
    "static_path": os.path.join(os.path.dirname(__file__), "static"),
    "cookie_secret": "61oETzKXQAGaYdkL5gEmGeJJFuYh7EQnp2XdTP1o/Vo=",
    # "login_url": "/login",
    # "xsrf_cookies": True,
    'debug' : True,
}

application = tornado.web.Application([
    (r"/echo", EchoWebSocket),
    (r"/chatroom", ChatRoomWebSocket),
    ], **settings)

def main():
    application.listen(9999)
    try:
        tornado.ioloop.IOLoop.instance().start()
    except KeyboardInterrupt:
        print "bye!"

if __name__ == "__main__":
    main()
