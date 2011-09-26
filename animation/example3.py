#!/usr/bin/env python
#-*- coding:utf-8 -*-
"""
module: example3
"""
from PyQt4.QtCore import *
from PyQt4.QtGui import *

def main():
    app = QApplication([])

    dlg = QDialog()
    dlg.resize(500, 300)
    button = QPushButton("Button", dlg)

    # 我们先生成一个状态机
    machine = QStateMachine()

    # 然后给状态机加上几个状态:
    # 不同状态下, button的位置是不同的.
    state1 =  QState(machine)
    state1.assignProperty(button, "geometry", QRect(0, 0, 100, 30))
    state2 =  QState(machine)
    state2.assignProperty(button, "geometry", QRect(250, 250, 100, 30))
    machine.setInitialState(state1) # 初始状态是哪个
    
    # 然后, 我们需要设置状态变化的转换方式.
    transition1 = state1.addTransition(button.clicked, state2)
    transition2 = state2.addTransition(button.clicked, state1)

    # 把动作加到转换方式里面去
    an = QPropertyAnimation(button, "geometry")
    transition1.addAnimation(an)
    an2 = QPropertyAnimation(button, "geometry")
    transition2.addAnimation(an2)
    # 设置完了, 开始吧.
    machine.start()
    dlg.exec_()
    
if __name__=="__main__":
    main()
