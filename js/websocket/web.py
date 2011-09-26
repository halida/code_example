#!/usr/bin/env python
#-*- coding:utf-8 -*-
"""
module: server
"""
import os, time, logging
import tornado.ioloop, tornado.web

class ChatroomHandler(tornado.web.RequestHandler):
    def get(self):
        self.render("templates/chatroom.html")

settings = {
    "static_path": os.path.join(os.path.dirname(__file__), "static"),
    "cookie_secret": "61oETzKXQAGaYdkL5gEmGeJJFuYh7EQnp2XdTP1o/Vo=",
    # "login_url": "/login",
    # "xsrf_cookies": True,
    'debug' : True,
}

application = tornado.web.Application([
    (r"/", ChatroomHandler),
    ], **settings)

def main():
    application.listen(8080)
    try:
        tornado.ioloop.IOLoop.instance().start()
    except KeyboardInterrupt:
        print "bye!"

if __name__ == "__main__":
    main()
