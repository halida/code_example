#!/usr/bin/env python
#-*- coding:utf-8 -*-
"""
module: example1
"""
from PyQt4.QtCore import *
from PyQt4.QtGui import *

def main():
    app = QApplication([])
    
    # 动来动去的按钮
    button = QPushButton("Button")
    button.show()

    # 生成一个动画, 它会修改button的geometry属性
    animation = QPropertyAnimation(button, "geometry")
    # 动画时间是10秒
    animation.setDuration(10000)
    # 开始的位置
    animation.setStartValue(QRect(0, 0, 100, 30))
    # 结束的位置
    animation.setEndValue(QRect(250, 250, 100, 30))
    # 开始吧
    animation.start()

    app.exec_()
    
if __name__=="__main__":
    main()
