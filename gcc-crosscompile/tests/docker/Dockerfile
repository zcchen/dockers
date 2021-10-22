ARG DEBIAN_VERSION=stable
ARG REGISTRY_AND_REPO

FROM --platform=amd64 ${REGISTRY_AND_REPO}/gcc-${TARGETARCH}:latest as compiling

ADD program /work/program

RUN cd /work/program && \
    cmake -B build && \
    cmake --build build


FROM --platform=${TARGETARCH} debian:stable
COPY --from=compiling /work/program/build/src/hello /hello
COPY docker/command.sh /

CMD ["/bin/bash", "/command.sh"]

# vim: ft=dockerfile

