build:
	rm -f static.go
	go get -u github.com/mjibson/esc
	go generate esc -o static.go -prefix ../frontend/build ../frontend/build
	ls
	cat static.go
	go build -o server *.go
