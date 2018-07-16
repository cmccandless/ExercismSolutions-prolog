.PHONY: lint test
lint:
	@echo "No linter configured"

test:
	@echo "Testing $(FILES)"
	@ $(foreach FILE,$(FILES), \
		$(call dotest,$(FILE)) \
	)

test-all:
	@ $(foreach FILE,$(shell ls -d */), \
		$(call dotest, $(FILE)) \
	)

define dotest
	cd $(1); \
	swipl -f *.pl -s *_tests.plt -g run_tests,halt -t 'halt(1)' || exit 1; \
	cd ..;
endef
