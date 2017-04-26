.PHONY : compile clean

compile:
	export GOPATH=$$(cd ../../.gopath && pwd) && \
	go get github.com/pelletier/go-toml && \
	go build $$GOPATH/src/github.com/pelletier/go-toml/cmd/test_program.go

clean:
	rm -rf ../../.gopath/pkg/*/github.com/pelletier
	rm -rf test_program
