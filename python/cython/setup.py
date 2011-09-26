#!/usr/bin/env python
#-*- coding:utf-8 -*-
"""
module: setup
"""

from distutils.core import setup
from distutils.extension import Extension
from Cython.Distutils import build_ext

setup(
    cmdclass = {'build_ext': build_ext},
    ext_modules = [Extension("calculator", ["calculator.pyx"])]
)
