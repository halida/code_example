//-*-coding:utf-8-*-
//----------------------------------------------------------
// module: hello
//----------------------------------------------------------
#ifndef __HELLO_HPP__
#define __HELLO_HPP__

#include <QLabel>

class Hello: public QLabel{
Q_OBJECT
public:
    Hello(QWidget *parent = 0);
}

#endif

