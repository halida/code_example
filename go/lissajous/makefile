build_run: run.bin
	./$< > out.gif
	o out.gif

run:
	go run hello.go

run.bin:
	go build -o run.bin main.go

clean:
	rm -f *.bin out.gif

format:
	gofmt -w hello.go
