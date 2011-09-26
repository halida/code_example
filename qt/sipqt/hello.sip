// Define the SIP wrapper to the hello library.

%Module hello 0

%Import QtGui/QtGuimod.sip

class Hello : QLabel {

%TypeHeaderCode
#include <hello.hpp>
%End

public:
    Hello(QWidget *parent /TransferThis/ = 0);
};

