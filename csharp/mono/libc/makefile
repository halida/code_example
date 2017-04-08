MONO_PATH=/Library/Frameworks/Mono.framework/Versions/Current/bin
run: build
	./demo.bin
build:
	gcc demo.c `$(MONO_PATH)/pkg-config --cflags --libs mono-2` -o demo.bin
