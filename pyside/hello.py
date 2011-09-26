#!/usr/bin/env python
#-*- coding:utf-8 -*-
"""
module: hello
"""
from PySide.QtCore import *
from PySide.QtGui import *

app = QApplication([])
lb = QLabel('<h1>hello world!</h1>')
lb.show()
app.exec_()

