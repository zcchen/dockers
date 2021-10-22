DEBIAN_VERSION = stable

IMAGE_ARGS :=
IMAGE_ARGS += APT_MIRROR="http://mirrors.163.com"
IMAGE_ARGS += DEBIAN_VERSION=$(DEBIAN_VERSION)

DOCKER_BUILD_ENV  = DOCKER_BUILDKIT=1
DOCKER_BUILD_CMD  = build
DOCKER_BUILD_ARGV := --no-cache --compress
DOCKER_BUILD_ARGV += $(foreach img_arg,$(IMAGE_ARGS), --build-arg $(img_arg))

BUILD_TMP_DIR     = build

.PHONY: all clean
all: \
  $(BUILD_TMP_DIR)/gcc-amd64 $(BUILD_TMP_DIR)/gcc-arm64

clean: \
  $(BUILD_TMP_DIR)/gcc-amd64/clean $(BUILD_TMP_DIR)/gcc-arm64/clean

$(BUILD_TMP_DIR)/gcc-amd64: $(BUILD_TMP_DIR)
	$(DOCKER_BUILD_ENV) docker $(DOCKER_BUILD_CMD) $(DOCKER_BUILD_ARGV) \
		-t $(notdir $@):latest -t $(notdir $@):$(DEBIAN_VERSION) \
		$(notdir $@)
	touch $@
$(BUILD_TMP_DIR)/gcc-amd64/clean:
	-docker rmi gcc-amd64:latest gcc-amd64:$(DEBIAN_VERSION)
	-rm $(BUILD_TMP_DIR)/gcc-amd64

$(BUILD_TMP_DIR)/gcc-arm64: $(BUILD_TMP_DIR)
	$(DOCKER_BUILD_ENV) docker $(DOCKER_BUILD_CMD) $(DOCKER_BUILD_ARGV) \
		-t $(notdir $@):latest -t $(notdir $@):$(DEBIAN_VERSION) \
		$(notdir $@)
	touch $@
$(BUILD_TMP_DIR)/gcc-arm64/clean:
	-docker rmi gcc-arm64:latest gcc-arm64:$(DEBIAN_VERSION)
	-rm $(BUILD_TMP_DIR)/gcc-arm64

$(BUILD_TMP_DIR):
	mkdir -p $@
