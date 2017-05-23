FROM ubuntu:17.04

# Old Mantainer: Ilias Kiourktsidis "ekiourk@gmail.com"
MAINTAINER Leonardo Amaral "git@leonardoamaral.com.br"

RUN add-apt-repository universe && \
 sed -i -e "s,archive.ubuntu.com,br.archive.ubuntu.com,g" /etc/apt/sources.list && \
 apt-get update && \
 apt-get install -y curl zlib1g-dev libpng-dev libpng16-16 libjpeg9-dev libjpeg9 libgpac-dev libgpac4 gpac gcc ns2 nam patch bzip2 make tar ffmpeg tcl
# apt -y install curl bzip2 tar patch make

# Evalvid building

RUN mkdir -p /tmp/evalvid-build
WORKDIR /tmp/evalvid-build
ADD evalvid.diff evalvid.diff
RUN curl http://www2.tkn.tu-berlin.de/research/evalvid/EvalVid/evalvid-2.7.tar.bz2 | tar -xj && \ 
 patch -p1 < evalvid.diff && \
 make install
WORKDIR /tmp

# Cleanup
RUN mkdir /project && \
 rm -rf evalvid-build && \
 apt-get -y purge libgpac-dev zlib1g-dev libjpeg9-dev libpng-dev gcc patch bzip2 make && \
 apt-get -y autoremove && \
 apt-get -y autoclean && \
 rm -rf /var/lib/apt/lists/*

WORKDIR /project
