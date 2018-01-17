nbuild_run: main.bin
	./$<

run:
	go run main.go

main.bin:
	go build -o main.bin main.go

clean:
	rm *.bin

format:
	gofmt -w main.go

install:
	go get -u github.com/kataras/iris
