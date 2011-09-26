#!/usr/bin/env python
#-*- coding:utf-8 -*-
"""
module: simple
"""
from PyQt4.QtCore import *
from PyQt4.QtGui import *
from PyQt4.Qwt5.qplt import *

import numpy as np

def testFit():
    app = QApplication([])

    plot = QwtPlot()

    c1 = QwtPlotCurve("c1")
    x = np.arange(100)
    y = np.sin(x/3.0)
    c1.setData(x, y)

    c1.setCurveAttribute(Qwt.QwtPlotCurve.Fitted)
    fitter = QwtSplineCurveFitter()
    fitter.setSplineSize(50000)
    c1.setCurveFitter(fitter)

    c1.attach(plot)

    plot.show()
    app.exec_()


class Main(QMainWindow):
    def __init__(self):
        super(Main, self).__init__()

        self.x = np.arange(100) / 3.0
        self.y1 = np.sin(self.x)
        self.y2 = np.cos(self.x)

        self.plot = QwtPlot()
        self.c1 = QwtPlotCurve("c1")
        # self.c1.setCurveAttribute(QwtPlotCurve.Fitted, True)
        # self.c1.setPaintAttribute(QwtPlotCurve.PaintFiltered, True)
        self.c1.setRenderHint(QwtPlotItem.RenderAntialiased)
        
        self.c1.setData(self.x, self.y1)
        self.fitter = QwtSplineCurveFitter()
        self.fitter.setSplineSize(0.1)
        self.c1.setCurveFitter(self.fitter)
        
        self.c1.attach(self.plot)

        # self.c2 = QwtPlotCurve("c2")
        # self.c2.setData(self.x, self.y2)
        # self.c2.attach(self.plot)

        # self.plot.setAxisScale(X1, 0, 2)
        # print self.plot.axisStepSize(X1)

        # self.plot.setAxisMaxMajor(X1, 100)
        # self.plot.setAxisMaxMinor(X1, 100)

        # div = QwtScaleDiv(100.0, 10000.0, 10.0, 10.0, 10.0)
        # self.plot.setAxisScaleDiv(X1, div)


        self.panner = QwtPlotPanner(self.plot.canvas())
        self.panner.setMouseButton (Qt.LeftButton)
        
        self.setCentralWidget(self.plot)
        #self.showMaximized()
        self.resize(800, 600)

def main():
    # app = QApplication([])
    # m = Main()
    # m.show()
    testFit()
    # app.exec_()
    
if __name__=="__main__":
    main()
