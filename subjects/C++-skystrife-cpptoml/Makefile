compile: cpptoml/cpptoml-parser

cpptoml/cpptoml-parser: cpptoml/Makefile
	cd cpptoml && \
	make

cpptoml/Makefile:
	cd cpptoml && \
	cmake .

clean:
	cd cpptoml && \
	git clean -xdf
