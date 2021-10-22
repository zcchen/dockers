ARG DEBIAN_VERSION=stable
FROM debian:${DEBIAN_VERSION}

ARG APT_MIRROR

RUN if [ -n "${APT_MIRROR}" ]; then \
  sed -i /etc/apt/sources.list -e "s#http://\([a-zA-Z0-9]\+\.*\)\{1,\}/#${APT_MIRROR}/#" ;\
  fi

RUN apt update && \
    apt install -y gcc-aarch64-linux-gnu g++-aarch64-linux-gnu crossbuild-essential-arm64 cmake make ; \
    apt install -f && \
    apt clean

RUN mkdir -p /work
WORKDIR /work

ARG COMPILER_PREFIX=aarch64-linux-gnu
ENV CC=${COMPILER_PREFIX}-gcc \
    CXX=${COMPILER_PREFIX}-g++ \
    CMAKE_C_COMPILER=${COMPILER_PREFIX}-gcc \
    CMAKE_CXX_COMPILER=${COMPILER_PREFIX}-g++ \
    STRIP=${COMPILER_PREFIX}-strip \
    RANLIB=${COMPILER_PREFIX}-ranlib \
    AS=${COMPILER_PREFIX}-as \
    AR=${COMPILER_PREFIX}-ar \
    LD=${COMPILER_PREFIX}-ld \
    FC=${COMPILER_PREFIX}-gfortran
