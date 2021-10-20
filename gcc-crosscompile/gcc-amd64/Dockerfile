ARG DEBIAN_VERSION=stable
FROM debian:${DEBIAN_VERSION}

ARG APT_MIRROR

RUN if [ -n "${APT_MIRROR}" ]; then \
  sed -i /etc/apt/sources.list -e "s#http://\([a-zA-Z0-9]\+\.*\)\{1,\}/#${APT_MIRROR}/#" ;\
  fi

RUN apt update && \
    apt install -y gcc g++ build-essential cmake make ; \
    apt install -f && \
    apt clean

RUN mkdir -p /work
WORKDIR /work

ARG COMPILER_PREFIX
