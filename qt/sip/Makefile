TARGET = word.so
OFILES = sipwordcmodule.o sipwordWord.o
HFILES = sipAPIword.h 

CC = gcc
CXX = g++
LINK = g++
CPPFLAGS = -DNDEBUG -I. -I/usr/include/python2.6
CFLAGS =  -O2 -g -fPIC -Wall -W
CXXFLAGS =  -O2 -g -fPIC -Wall -W
LFLAGS = -shared -Wl,--version-script=word.exp  -L./
LIBS = -lword
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
	@echo '{ global: initword; local: *; };' > word.exp
	$(LINK) $(LFLAGS) -o $(TARGET) $(OFILES) $(LIBS)

install: $(TARGET)
	@test -d $(DESTDIR)/usr/lib/python2.6/dist-packages || mkdir -p $(DESTDIR)/usr/lib/python2.6/dist-packages
	cp -f $(TARGET) $(DESTDIR)/usr/lib/python2.6/dist-packages/$(TARGET)

clean:
	-rm -f $(TARGET)
	-rm -f sipwordcmodule.o
	-rm -f sipwordWord.o
	-rm -f word.exp
