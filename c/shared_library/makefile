run: p
	./p

p: lib.so main.c
	gcc -o p main.c ./lib.so

lib.so: lib.h lib.c
	gcc -fPIC -shared -o lib.so lib.c