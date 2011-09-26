#!/usr/bin/env python
#-*- coding:utf-8 -*-
"""
module: note
"""
from PyQt4.QtCore import *
from PyQt4.QtGui import *

import random

def inputBox(msg):
    name, result = QInputDialog.getText(
        None, "", msg,
        QLineEdit.Normal, "")

    if not result: return
    return name


class Note(QGraphicsRectItem):
    def __init__(self, text="empty"):
        QGraphicsRectItem.__init__(self, 0, 0, 80, 80)

        self.setFlag(QGraphicsItem.ItemIsMovable, True)
        self.setBrush(Qt.red)

        self.text = QGraphicsTextItem(text, self)
        self.text.setPos(10, 10)

    def mouseDoubleClickEvent(self, event):
        name = inputBox("change name:")
        if not name: return
        self.text.setPlainText(name)

def main():
    app = QApplication([])

    scene = QGraphicsScene()
    for i in range(10):
        note = Note()
        scene.addItem(note)
        
    view = QGraphicsView(scene)
    view.show()

    app.exec_()

if __name__=="__main__":
    main()
