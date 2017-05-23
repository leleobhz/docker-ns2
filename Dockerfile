FROM ubuntu:17.04

# Old Mantainer: Ilias Kiourktsidis "ekiourk@gmail.com"
MAINTAINER Leonardo Amaral "git@leonardoamaral.com.br"

RUN sed -i -e "s,archive.ubuntu.com,br.archive.ubuntu.com,g" /etc/apt/sources.list && \
 apt-get update && apt-get -y install apt-utils && \
 apt install -y curl zlib1g-dev libpng-dev libpng16-16 libjpeg9-dev libjpeg9 libgpac-dev libgpac4 gpac build-essential ns2 ns2-doc ns2-examples nam xgraph sgb cwebx && \
 rm -rf /var/lib/apt/lists/*

# Evalvid building

RUN mkdir -p /tmp/evalvid-build
WORKDIR /tmp/evalvid-build
ADD evalvid.diff evalvid.diff
RUN curl http://www2.tkn.tu-berlin.de/research/evalvid/EvalVid/evalvid-2.7.tar.bz2 | tar -xj 
RUN patch -p1 < evalvid.diff
RUN make install
WORKDIR /tmp
RUN rm -rf evalvid-build

# Cleanup
RUN apt -y purge build-essential libgpac-dev zlib1g-dev libjpeg9-dev libpng-dev

WORKDIR /tmp
