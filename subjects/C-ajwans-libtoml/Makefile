compile: libtoml/parser_test

libtoml/parser_test: libtoml/main
	cp libtoml/main libtoml/parser_test

libtoml/main:
	brew bundle && \
	brew bundle exec make docompile

docompile:
	cd libtoml && \
	cmake . && \
	make

clean:
	cd libtoml && \
	git clean -xdf
