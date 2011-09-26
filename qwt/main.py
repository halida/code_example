#!/usr/bin/env python
#-*- coding:utf-8 -*-
"""
module: qwt example
"""
# 导入Qt的对象
import os, sys
from PyQt4 import QtGui 

# 一些其他的库
import time, os.path, random
import numpy as np

# 导入qwt的对象
from PyQt4.Qwt5.qplt import *
# from PyQt4.Qwt5.anynumpy import *

class BarPlot(QwtPlot):
    """
    直方图
    通过loadData导入数据,
    可以通过setWarningLine设置警戒线
    可以通过setSelected设置点选的直方.
    当鼠标点选一个直方的时候, 会触发selected事件
    """
    selected = pyqtSignal(int)

    def __init__(self):
        super(BarPlot, self).__init__()
        # 背景
        self.setCanvasBackground(Qt.white)
        # 网格
        self.grid = QwtPlotGrid()
        self.grid.attach(self)
        self.grid.setPen(QPen(Qt.black, 0, DotLine))
        # bar曲线 
        self.curve = BarCurve("直方")
        self.curve.setSymbol(Symbol(Circle, Red))
        self.curve.attach(self)
        # 可以点选一个直方
        self.picker = QwtPlotPicker(
            QwtPlot.xBottom,
            QwtPlot.yLeft,
            QwtPicker.PointSelection | QwtPicker.DragSelection,
            QwtPlotPicker.CrossRubberBand,
            QwtPicker.AlwaysOff,
            self.canvas())
        self.picker.setRubberBandPen(QPen(Qt.green))
        self.picker.setTrackerPen(QPen(Qt.blue))
        # 点击一个Bar的时候触发事件, 通知其他控件
        self.picker.selected.connect(self.__showSelect)
        # 初始化数据
        self.setData([0],[1.0])

    def setData(self, x, y):
        """设置数据"""
        self.x = x
        self.y = y
        self.x_range = min(100,
                           max(4,
                               len(x) / 2))
        self.y_range = max(y)
        self.x_pos = len(x) / 2

        self.curve.setData(self.x,self.y)
        self.updateView()

    def setSelected(self, selected):
        """用来设置选择了哪些直方"""
        if self.curve.setSelected(selected):
            self.replot()
            if len(selected) > 0:
                self.updateView(min(selected))

    def setXRange(self, size):
        """设置X的范围"""
        self.x_range = size
        self.updateView()

    def setYRange(self, size):
        """设置Y的范围(%)"""
        self.y_range = size / 100.0 * max(self.y)
        self.updateView()

    def updateView(self, x=None):
        """显示选择的部分"""
        if x == None:
            x = self.x_pos
        else:
            self.x_pos = x
        self.setAxisScale(X1, x - self.x_range, x + self.x_range)
        self.setAxisScale(Y1, 0, self.y_range)
        self.replot()

    def getX(self, i):
        return xMap.transform(self.curve.x(i))

    def setWarningLine(self, value):
        """设置警戒线"""
        self.curve.setWarningLine(value)

    def __showSelect(self, p):
        """
        点击图形，自动选择对应的列表项目
        """
        #获取点击的直方
        c = None
        for i in range(len(self.x)-1):
            if self.x[i] <= p.x() <= self.x[i+1]:
                c = i
                break
        if c == None:
            c = len(self.x)-1
        # 设置点选
        self.setSelected(set([c]))
        # 以及触发事件
        self.selected[int].emit(c)

BAR_FIX = 0
BAR_INT = 1
class BarCurve(Qwt.QwtPlotCurve):
    """
    数据显示为直方图
    可以设置警戒线
    可以设置选择了那个直方
    可以设置直方图的格式：
    定长：每个直方宽度为1
    间距：每个直方宽度为x - x+1
    """
    def __init__(self, name, 
                 color = Qt.green,
                 alertColor = Qt.red,
                 selectedColor = Qt.blue,
                 alertLineColor = Qt.darkBlue,
                 format=BAR_FIX):
        super(BarCurve, self).__init__(name)
        self.selected = []
        self.warningLine = None

        self.color = color
        self.alertColor = alertColor
        self.alertLineColor = alertLineColor
        self.selectedColor = selectedColor
        self.format = format

    def setWarningLine(self, value):
        "设置警戒线"
        self.warningLine = value

    def setSelected(self, selected):
        "设置选择的直方"
        if self.selected != selected:
            self.selected = selected
            return True
    
    def drawFromTo(self, painter, xMap, yMap, start, stop):
        """具体的画图函数"""
        #开始和结束
        if stop == -1:
            stop = self.dataSize()
        if start & 1:
            start -= 1
        if stop & 1:
            stop -= 1
        start = max(start, 0)
        stop = max(stop, 0)

        #对每一个数据，画直方
        for i in range(start, stop, 1):
            if (i == stop and self.format == BAR_INT):
                continue
            #if i == start: continue
            px1 = xMap.transform(self.x(i))
            if self.format == BAR_FIX:
                px2 = xMap.transform(self.x(i)+1)
            else:
                px2 = xMap.transform(self.x(i-1))
            py1 = yMap.transform(0.0)
            py2 = yMap.transform(self.y(i))

            #当前选中的，变换颜色
            if i in self.selected:
                color = self.selectedColor
            #超过警戒线的，变换颜色
            elif (self.warningLine!=None and 
                self.y(i)>= self.warningLine):
                color = self.alertColor
            else:
                color = self.color
            painter.setBrush(color)

            painter.drawRect(QRectF(px1, py1, px2-px1, py2-py1))

        #画警戒线
        if self.warningLine != None:
            painter.setPen(QPen(self.alertLineColor, 4, Qt.DashLine))
            painter.drawLine(
                xMap.p1(),
                yMap.transform(self.warningLine),            
                xMap.p2(),
                yMap.transform(self.warningLine),            
                )

def main():
    # 生成模拟数据, 是count个随机数
    count = 12
    x = np.array(range(count))
    y = np.array([random.random() * 1000
                  for i in range(count)])

    app = QtGui.QApplication(sys.argv)
    # 生成谱图
    plot = BarPlot()
    plot.setData(x, y)
    plot.setWarningLine(500)
    plot.show()

    app.exec_()
    
if __name__=="__main__":
    main()
