ARG DOCKER_REGISTRY=docker.io
ARG FROM_IMG_REPO=qnib
ARG FROM_IMG_NAME="uplain-init"
ARG FROM_IMG_TAG="latest"
ARG FROM_IMG_HASH=""
FROM ${DOCKER_REGISTRY}/${FROM_IMG_REPO}/${FROM_IMG_NAME}:${FROM_IMG_TAG}${DOCKER_IMG_HASH}


RUN apt-get update \
 && apt-get install -y automake curl gcc g++ gfortran lbzip2 make patch python apt-transport-https \
    ca-certificates \
    curl \
    software-properties-common \
    wget \
 && curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add - \
 && add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" \
 && apt-get update \
 && apt-get install -y docker-ce
RUN mkdir -p /usr/local/src/spack/ \
 && wget -qO - https://github.com/spack/spack/archive/v0.12.1.tar.gz |tar xfz - -C /usr/local/src/spack/ --strip-component=1
ENV PATH=${PATH}:/usr/local/src/spack/bin/
CMD ["tail", "-f", "/dev/null"]
RUN  echo "Download: $(/usr/local/bin/go-github rLatestUrl --ghorg qnib --ghrepo go-wharfie --regex 'go-wharfie_x86' --limit 1)" \
 && wget -qO /usr/local/bin/go-wharfie $(/usr/local/bin/go-github rLatestUrl --ghorg qnib --ghrepo go-wharfie --regex 'go-wharfie_x86' --limit 1) \
 && chmod +x /usr/local/bin/go-wharfie
RUN groupadd -g 1000 clgrp \
 && useradd -s /bin/false -d /home/cluser -u 1000 -g 1000 cluser
