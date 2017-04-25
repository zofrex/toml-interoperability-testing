.PHONY : kora-clean loltoml-clean clean compile

compile: loltoml/examples/toml-test-decoder

loltoml/examples/toml-test-decoder: loltoml/examples/Makefile prefix/lib/libkora-util.dylib .bundled
	cd loltoml/examples && \
	CPLUS_INCLUDE_PATH=../include:../../prefix/include LIBRARY_PATH=../../prefix/lib make toml-test-decoder
	touch loltoml/examples/toml-test-decoder

loltoml/examples/Makefile: .bundled
	cd loltoml/examples && \
	CXX=g++-6 cmake .

loltoml-clean:
	cd loltoml && \
	git clean -xdf

prefix/lib/libkora-util.dylib: util/Makefile .bundled
	cd util && \
	make install
	touch prefix/lib/libkora-util.dylib

util/Makefile: .bundled
	cd util && \
	CXX=g++-6 cmake -DCMAKE_INSTALL_PREFIX:PATH=../prefix

.bundled:
	brew bundle
	touch .bundled

kora-clean:
	rm -rf prefix && \
	cd util && \
	git clean -xdf

clean: loltoml-clean kora-clean
