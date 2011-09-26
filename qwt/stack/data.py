#!/usr/bin/env python
#-*- coding:utf-8 -*-
"""
module: data

导入股票数据资料
"""
import csv

def getData(filename):
    reader = csv.reader(open(filename), delimiter=',')
    out = [row for row in reader][1:]
    out.reverse()
    return out

def main():
    for r in getData('table.csv'):
        print ', '.join(r)
    
if __name__=="__main__":
    main()
