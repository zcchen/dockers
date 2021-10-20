IMAGE_ARGS :=
IMAGE_ARGS += APT_MIRROR="http://mirrors.ustc.edu.cn"

DOCKER_BUILD_ENV  = DOCKER_BUILDKIT=1
DOCKER_BUILD_CMD  = build
DOCKER_BUILD_ARGV := --no-cache
DOCKER_BUILD_ARGV += $(foreach img_arg,$(IMAGE_ARGS), --build-arg $(img_arg))

BUILD_TMP_DIR     = build

.PHONY: all clean
all: \
  $(BUILD_TMP_DIR)/gcc

$(BUILD_TMP_DIR)/gcc: $(BUILD_TMP_DIR)
	$(DOCKER_BUILD_ENV) docker $(DOCKER_BUILD_CMD) $(DOCKER_BUILD_ARGV) \
		-t $(notdir $@):latest $(notdir $@)
	touch $@

$(BUILD_TMP_DIR):
	mkdir -p $@
