TARGET = hello.so
OFILES = siphellocmodule.o siphelloHello.o
HFILES = sipAPIhello.h 

CC = gcc
CXX = g++
LINK = g++
CPPFLAGS = -DNDEBUG -DQT_NO_DEBUG -DQT_CORE_LIB -DQT_GUI_LIB -I. -I/usr/include/python2.6 -I/usr/share/qt4/mkspecs/default -I/usr/include/qt4/QtCore -I/usr/include/qt4/QtGui -I/usr/include/qt4 -I/usr/X11R6/include
CFLAGS = -pipe -fPIC -Os -Wall -W -D_REENTRANT
CXXFLAGS = -pipe -fPIC -g -O2 -Os -Wall -W -D_REENTRANT
LFLAGS = -shared -Wl,-Bsymbolic-functions -Wl,-O1 -Wl,--version-script=hello.exp
LIBS = -L/usr/lib -L/usr/X11R6/lib -lhello -lQtCore -lQtGui
MOC = moc-qt4
.SUFFIXES: .c .o .cpp .cc .cxx .C


.cpp.o:
	$(CXX) -c $(CXXFLAGS) $(CPPFLAGS) -o $@ $<

.cc.o:
	$(CXX) -c $(CXXFLAGS) $(CPPFLAGS) -o $@ $<

.cxx.o:
	$(CXX) -c $(CXXFLAGS) $(CPPFLAGS) -o $@ $<

.C.o:
	$(CXX) -c $(CXXFLAGS) $(CPPFLAGS) -o $@ $<

.c.o:
	$(CC) -c $(CFLAGS) $(CPPFLAGS) -o $@ $<

all: $(TARGET)

$(OFILES): $(HFILES)

$(TARGET): $(OFILES)
	@echo '{ global: inithello; local: *; };' > hello.exp
	$(LINK) $(LFLAGS) -o $(TARGET) $(OFILES) $(LIBS)

install: $(TARGET)
	@test -d $(DESTDIR)/usr/lib/python2.6/dist-packages || mkdir -p $(DESTDIR)/usr/lib/python2.6/dist-packages
	cp -f $(TARGET) $(DESTDIR)/usr/lib/python2.6/dist-packages/$(TARGET)
	@test -d $(DESTDIR)/usr/share/sip/hello || mkdir -p $(DESTDIR)/usr/share/sip/hello
	cp -f hello.sip $(DESTDIR)/usr/share/sip/hello/hello.sip

clean:
	-rm -f $(TARGET)
	-rm -f siphellocmodule.o
	-rm -f siphelloHello.o
	-rm -f hello.exp
