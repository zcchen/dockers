#!/usr/bin/env sh

set -ex

test_image()
{
    local platform=$1
    DOCKER_BUILDKIT=1 docker build -t hello-${platform} -f docker/Dockerfile.${platform} .
    # use qemu binfmt solution to execute the docker image
    docker run --rm -it hello-${platform}
    docker rmi hello-${platform}
}

test_image amd64
test_image arm64
