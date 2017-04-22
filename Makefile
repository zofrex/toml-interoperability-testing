SUBDIRS := $(wildcard subjects/*/.)
TARGETS := compile clean

compile-all: compile toml-test/toml-test

compile-tester: toml-test/toml-test

toml-test/toml-test:
	cd toml-test && \
	go build

clean-all: clean clean-tester

clean-tester:
	cd toml-test && \
	git clean -xdf

SUBDIRS_TARGETS := $(foreach t,$(TARGETS),$(addsuffix $t,$(SUBDIRS)))

.PHONY : $(TARGETS) $(SUBDIRS_TARGETS) compile-all compile-tester clean-all clean-tester

$(TARGETS) : % : $(addsuffix %,$(SUBDIRS))
	@echo 'Done "$*" target'

$(SUBDIRS_TARGETS) :
	$(MAKE) -C $(@D) $(@F:.%=%)
