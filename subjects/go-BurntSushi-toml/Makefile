.PHONY : compile clean

compile:
	export GOPATH=$$(cd ../../.gopath && pwd) && \
	go get github.com/BurntSushi/toml && \
	go install github.com/BurntSushi/toml/cmd/toml-test-decoder

clean:
	rm -r ../../.gopath/bin/toml-test-decoder
