build:
	go get -u github.com/mjibson/esc
	esc -o static.go -prefix ../frontend/build/static ../frontend/build/static
	go build -o server *.go
