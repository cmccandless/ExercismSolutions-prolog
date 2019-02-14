EXTENSION:=pl
TEST_EXTENSION:=plt

SOURCE_FILES := $(shell find */* -type f -name '*$(EXTENSION)')
TEST_FILES := $(shell find */* -type f -name '*$(TEST_EXTENSION)')
EXERCISES := $(dir $(SOURCE_FILES))
OUT_DIR=.build
OBJECTS=$(addprefix $(OUT_DIR)/,$(EXERCISES))


.PHONY: test no-skip clean all
all: no-skip test

no-skip:
	@ ! grep -rE '.*condition\(pending\).*' .

clean:
	rm -rf $(OUT_DIR)

test: $(EXERCISES)

$(EXERCISES): %: $(OUT_DIR)/%

$(OUT_DIR):
	@ mkdir -p $@

.SECONDEXPANSION:

GET_DEP = $(filter $(patsubst $(OUT_DIR)/%,%,$@)%,$(SOURCE_FILES) $(TEST_FILES))
$(OBJECTS): $$(GET_DEP) | $(OUT_DIR)
	$(eval EXERCISE := $(patsubst $(OUT_DIR)/%,%,$@))
	@ echo "Testing $(EXERCISE)..."
	@ cd $(EXERCISE) && swipl -f *.pl -s *_tests.plt -g run_tests,halt -t 'halt(1)'
	@ touch $@
