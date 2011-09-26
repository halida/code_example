#!/usr/bin/env python
#-*- coding:utf-8 -*-
"""
module: draw
"""

from PySide.QtCore import *
from PySide.QtGui import *
from PySide.QtUiTools import QUiLoader

app = QApplication([])
loader = QUiLoader()

class Inputer():
    def __init__(self):
        self.dlg = loader.load('draw.ui')
        self.dlg.leInput.returnPressed.connect(self.input)

    def input(self):
        text = self.dlg.leInput.text()
        if not text: return
        self.dlg.lwData.insertItem(0, text)
        self.dlg.leInput.clear()

    def exec_(self):
        self.dlg.exec_()


class MyQUiLoader(QUiLoader):
   def __init__(self, baseinstance):
       super(MyQUiLoader, self).__init__()
       self.baseinstance = baseinstance

   def createWidget(self, className, parent=None, name=""):
       widget = QUiLoader.createWidget(self, className, parent, name)
       if parent is None:
           return self.baseinstance
       else:
           setattr(self.baseinstance, name, widget)
           return widget


class Inputer(QDialog):
    def __init__(self):
        super(Inputer, self).__init__()
        loadUi('draw.ui', self)
        self.leInput.returnPressed.connect(self.input)

    def input(self):
        text = self.leInput.text()
        if not text: return
        self.lwData.insertItem(0, text)
        self.leInput.clear()

        
def loadUi(uifile, baseinstance=None):
   loader = MyQUiLoader(baseinstance)
   ui = loader.load(uifile)
   QMetaObject.connectSlotsByName(ui)
   return ui
   

def main():
    inputer = Inputer()
    inputer.exec_()
    
if __name__=="__main__":
    main()


