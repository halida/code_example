#!/usr/bin/env python
#-*- coding:utf-8 -*-
"""
module: hello
"""
from PySide.QtCore import *
from PySide.QtGui import *


class Caculator(QDialog):
    def __init__(self):
        super(Caculator, self).__init__()
        #widgets
        self.leInput = QLineEdit()
        self.lwResult = QListWidget()
        #layouts
        l = QVBoxLayout(self)
        for w in self.leInput, self.lwResult:
            l.addWidget(w)
        #events
        self.leInput.returnPressed.connect(self.caculate)

    def caculate(self):
        data = unicode(self.leInput.text())
        if not data: return
        self.leInput.clear()

        try:
            result = unicode(eval(data))
        except Exception as e:
            result = unicode(e)

        self.lwResult.addItem(result)


def main():
    app = QApplication([])
    Caculator().exec_()

if __name__=="__main__":
    main()

