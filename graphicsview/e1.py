#!/usr/bin/env python
#-*- coding:utf-8 -*-
"""
module: e1
"""
from PyQt4.QtCore import *
from PyQt4.QtGui import *

import random

class Body(QGraphicsRectItem):
    def __init__(self, timer):
        x = random.randint(0, 400)
        y = random.randint(0, 400)
        QGraphicsRectItem.__init__(self, x, y, 30, 30)
        self.setFlag(QGraphicsItem.ItemIsMovable, True)
        self.setBrush(Qt.red)

        self.animation = QGraphicsItemAnimation()
        self.animation.setItem(self)
        self.animation.setTimeLine(timer)

        rate = random.random() - 0.5
        for i in range(200):
            #self.animation.setPosAt(i / 200.0, QPointF(i, i))
            if i < 100:
                self.animation.setScaleAt(i / 200.0,
                                          1.0 + (i / 100.0) * rate,
                                          1.0 + (i / 100.0) * rate,
                                          )
            else:
                self.animation.setScaleAt(i / 200.0,
                                          1.0 + (2.0 - i / 100.0) * rate,
                                          1.0 + (2.0 - i / 100.0) * rate,
                                          )

def main():
    app = QApplication([])

    timer = QTimeLine(5000)
    timer.setFrameRange(0, 100)

    scene = QGraphicsScene()
    for i in range(100):
        body = Body(timer)
        scene.addItem(body)
        
    view = QGraphicsView(scene)
    view.show()
    timer.finished.connect(timer.start)
    timer.start()

    app.exec_()
    
if __name__=="__main__":
    main()
