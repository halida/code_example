jc=javac 
j=java

run: build
	java -jar AwtExample.jar

build: AwtExample.class
	jar -cvfm AwtExample.jar manifest.txt AwtExample.class

%.class: %.java
	$(jc) $<
