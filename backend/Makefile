build:
	go get -u github.com/mjibson/esc
	go generate esc -o static.go -prefix ../frontend/build/static ../frontend/build/static
	echo "$(cat static.go)"
	go build -o server *.go
