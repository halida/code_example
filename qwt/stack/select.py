#!/usr/bin/env python
#-*- coding:utf-8 -*-
"""
module: select

this example shows show to place a selector on plot,
and can presistanace this data.
"""
# 导入Qt的对象
import os, sys
from PyQt4 import QtGui 

# 一些其他的库
import time, os.path, random
import numpy as np

#qwt
from PyQt4.Qwt5.qplt import *

#local
import data

class Main(QMainWindow):
    def __init__(self):
        QMainWindow.__init__(self)

        plot = QwtPlot()
        self.setCentralWidget(plot)

        d = data.getData('table.csv')
        xs = np.arange(len(d))
        ps = np.array([float(i[6]) for i in d])
        ts = np.array([float(i[5]) for i in d])

        c2 = VolumeCurve()
        c2.setData(xs, ps, ts)
        c2.attach(plot)

        c1 = PriceCurve()
        c1.setData(xs, ps)
        c1.attach(plot)

        self.selector = Selector(plot)
        self.zoomer = Zoomer(plot)
        self.pickers = [self.selector, self.zoomer]
        self.select_picker(self.zoomer)

        self.panner = QwtPlotPanner(plot.canvas())
        self.panner.setMouseButton(Qt.MidButton)


        self.createActions()
        self.showMaximized()

    def createActions(self):
        self.zoomerAction = QAction('zoomer', self)
        self.zoomerAction.triggered.connect(
            lambda: self.select_picker(self.zoomer))
        self.selectorAction = QAction('selector', self)
        self.selectorAction.triggered.connect(
            lambda: self.select_picker(self.selector))
        
        self.picker_group = QActionGroup(self)
        self.picker_group.addAction(self.zoomerAction)
        self.picker_group.addAction(self.selectorAction)

        self.tb = QToolBar(self)
        for ac in self.zoomerAction, self.selectorAction:
            self.tb.addAction(ac)
        self.addToolBar(self.tb)

    def select_picker(self, picker):
        for p in self.pickers:
            p.setEnabled(False)
        picker.setEnabled(True)
        

class PriceCurve(QwtPlotCurve):
    def __init__(self):
        QwtPlotCurve.__init__(self)

class VolumeCurve(QwtPlotCurve):
    def __init__(self):
        QwtPlotCurve.__init__(self)
        self.level = 10000
        self.belowColor = Qt.green
        self.aboveColor = Qt.red

    def setData(self, xs, ps, ts):
        mv = max(ts)
        self.zoom = mv / 20.0
        self.level = mv / 2.0
        QwtPlotCurve.setData(self, xs, ps)
        self.ts = ts

    def drawFromTo(self, painter, xMap, yMap, start, stop):
        """Draws rectangles with the corners taken from the x- and y-arrays.
        """
        if stop == -1:
            stop = self.dataSize()
        # force 'start' and 'stop' to be even and positive
        if start & 1:
            start -= 1
        if stop & 1:
            stop -= 1
        start = max(start, 0)
        stop = max(stop, 0)
        for i in range(start, stop, 2):
            if self.ts[i] > self.level:
                color = self.aboveColor
            else:
                color = self.belowColor
                
            height = self.ts[i]/self.zoom
            px1 = xMap.transform(self.x(i)-0.4)
            py1 = yMap.transform(self.y(i)-height)
            px2 = xMap.transform(self.x(i)+0.4)
            py2 = yMap.transform(self.y(i)+height)

            painter.setBrush(color)
            painter.drawRect(px1, py1, (px2 - px1), (py2 - py1))

class Zoomer(QwtPlotZoomer):
    def __init__(self, parent):
        self.parent = parent
        QwtPlotZoomer.__init__(
            self, X1, Y1,
            QwtPicker.DragSelection,
            QwtPicker.AlwaysOff,
            self.parent.canvas())
        self.setRubberBandPen(QPen(Blue))
        #设置事件
        pattern = [
            QwtEventPattern.MousePattern(Qt.LeftButton,
                                         Qt.NoModifier),
            QwtEventPattern.MousePattern(Qt.MidButton,
                                         Qt.NoModifier),
            QwtEventPattern.MousePattern(Qt.RightButton,
                                         Qt.NoModifier),
            QwtEventPattern.MousePattern(Qt.LeftButton,
                                         Qt.ShiftModifier),
            QwtEventPattern.MousePattern(Qt.MidButton,
                                         Qt.ShiftModifier),
            QwtEventPattern.MousePattern(Qt.RightButton,
                                         Qt.ShiftModifier),
            ]
        self.setMousePattern(pattern)

class Selector(QwtPicker):
    def __init__(self, parent):
        QwtPicker.__init__(self, parent.canvas())
        self.parent = parent
        self.new_curve = None
        self.setTrackerMode(QwtPicker.AlwaysOff)
        self.setSelectionFlags(QwtPicker.PolygonSelection)
        self.selected.connect(self.onSelected)

    def onSelected(self, polygon):
        xs = []
        ys = []
        for i in range(polygon.size()):
            p = polygon.at(i)
            x = self.parent.invTransform(X1, p.x())
            y = self.parent.invTransform(Y1, p.y())            
            xs.append(x)
            ys.append(y)            

        if self.new_curve: self.new_curve.detach()
        self.new_curve = QwtPlotCurve('haha')
        self.new_curve.setPen(Qt.red)
        self.new_curve.setData(xs, ys)
        self.new_curve.attach(self.parent)
        self.parent.replot()

def main():
    app = QApplication([])

    m = Main()

    app.exec_()


if __name__=="__main__":
    main()

