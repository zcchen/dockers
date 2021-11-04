# docker related commands
DOCKER_BINARY_CMD = docker
DOCKER_BUILD_ENV  = DOCKER_BUILDKIT=1
DOCKER_BUILD_CMD  = build
DOCKER_BUILD_ARGV := --no-cache --compress

# handle the vitual target because docker image is not the files we can see easily.
DOT_DOCKER_FILENAME := .docker     # use the hidden dot files to make existing docker images
# docker build targets
DOCKER_DIR_NAMES = $(foreach d,$(sort $(dir $(wildcard */Dockerfile))),$(patsubst %/,%,$d))
DOCKER_DOT_TARGETS = $(foreach d,$(DOCKER_DIR_NAMES),$d/$(DOT_DOCKER_FILENAME))
# docker clean targets
DOCKER_DOT_EXISTING = $(sort $(wildcard */$(DOT_DOCKER_FILENAME)))
DOCKER_DOT_CLEANS = $(foreach d,$(DOCKER_DOT_EXISTING),$(patsubst %/.docker,%/clean,$d))


.PHONY: all clean

all: $(DOCKER_DOT_TARGETS)

clean: $(DOCKER_DOT_CLEANS)
	@echo "DOCKER_DOT_CLEANS: $^"
	@echo "DOCKER_DOT_EXISTING: $(DOCKER_DOT_EXISTING)"

# this `.docker` cannot be replace
%/.docker: %/args.txt %/Dockerfile %/tag.txt
	$(eval DOCKER_NAME = $(patsubst %/.docker,%,$@))
	$(DOCKER_BUILD_ENV) $(DOCKER_BINARY_CMD) $(DOCKER_BUILD_CMD) $(DOCKER_BUILD_ARGV) \
		$(DOCKER_NAME) -t $(DOCKER_NAME):$(file < $(DOCKER_NAME)/tag.txt) \
		$(foreach a,$(file < $(DOCKER_NAME)/args.txt), --build-arg $a)
	touch $@

# this `clean` cannot be replace
%/clean:
	$(eval DOCKER_NAME = $(patsubst %/clean,%,$@))
	$(eval DOCKER_IMG_IDs = $(sort $(shell docker images -q -f reference=$(DOCKER_NAME))))
	-$(DOCKER_BINARY_CMD) rmi -f $(DOCKER_IMG_IDs)
	-rm -rf $(patsubst %/clean,%/$(DOT_DOCKER_FILENAME),$@)
