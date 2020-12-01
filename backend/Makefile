build:
	go get -u github.com/mjibson/esc
	esc -o static.go -prefix ../frontend/build ../frontend/build
	ls
	cat static.go
	go build -o server *.go
