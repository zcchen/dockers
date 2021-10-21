How to Use `buildx` to build & push the multi-platform docker images to docker registry
============================================================================================

Prepare
-----------------------------------
1. Install `buildx` plugin.
   + Follow the official instructs to install the `buildx` plugin.
   + Use the following command to create the `moby/buildkit` container.
     ```
     docker buildx create --name buildx --use --driver-opt network=host --platform linux/amd64,linux/arm64
     ```

2. Prepare the registry server


Usage
-----------------------------------
Suppose your REGISTRY is `http://localhost:80/v2`, authorized REPO is `test`.

1. Login to your docker registry first
```
docker login localhost:80
```

2. Build & push the built images to docker registry
```
REPO="localhost:80/test"; \
docker buildx build -f docker/Dockerfile -t ${REPO}/hello --platform linux/amd64,linux/arm64 --push --build-arg REGISTRY_AND_REPO=${REPO} .
```
