SUBDIRS := $(wildcard subjects/*/.)
TARGETS := compile clean

compile-all: compile compile-tester

compile-tester:
	export GOPATH=$$(pwd)/.gopath && \
	go get github.com/BurntSushi/toml-test && \
	go install github.com/BurntSushi/toml-test

clean-all: clean clean-tester

clean-tester:
	cd toml-test && \
	git clean -xdf
	rm -rf .gopath/pkg/*/github.com/BurntSushi
	rm -rf .gopath/bin/toml-test

SUBDIRS_TARGETS := $(foreach t,$(TARGETS),$(addsuffix $t,$(SUBDIRS)))

.PHONY : $(TARGETS) $(SUBDIRS_TARGETS) compile-all compile-tester clean-all clean-tester

$(TARGETS) : % : $(addsuffix %,$(SUBDIRS))
	@echo 'Done "$*" target'

$(SUBDIRS_TARGETS) :
	$(MAKE) -C $(@D) $(@F:.%=%)
