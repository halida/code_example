run:	ext/my_test.bundle
	ruby app.rb

ext/my_test.bundle: build

build:
	rake build

clean:
	rm ext/*.bundle ext/*.o ext/Makefile ext/extconf.h
