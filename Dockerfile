ARG DOCKER_REGISTRY=docker.io
ARG FROM_IMG_REPO=qnib
ARG FROM_IMG_NAME="uplain-init"
ARG FROM_IMG_TAG="bionic-20181112_2018-12-08.1"
ARG FROM_IMG_HASH=""
FROM ${DOCKER_REGISTRY}/${FROM_IMG_REPO}/${FROM_IMG_NAME}:${FROM_IMG_TAG}${DOCKER_IMG_HASH}

RUN apt-get update \
 && apt-get install -y automake curl gcc g++ gfortran lbzip2 make patch python apt-transport-https \
    ca-certificates \
    curl \
    software-properties-common \
    wget
ARG SPACK_VER=0.12.0
RUN mkdir -p /usr/local/src/spack/ \
 && wget -qO - https://github.com/spack/spack/releases/download/v${SPACK_VER}/spack-${SPACK_VER}.tar.gz |tar xfz - -C /usr/local/src/spack/ --strip-component=1
ENV PATH=${PATH}:/usr/local/src/spack/bin/
RUN spack --version
CMD ["tail", "-f", "/dev/null"]
