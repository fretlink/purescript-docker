FROM node:9

MAINTAINER Risto Stevcev
ENV PURESCRIPT_DOWNLOAD_SHA1 f01eb69aa71f5f97c6980f8c68d107480c68ee64
ENV PSC_PACKAGE_DOWNLOAD_SHA1 bdf25acc5b4397bd03fd1da024896c5f33af85ce

RUN yarn global add pulp@11.0.0

RUN cd /opt \
    && wget https://github.com/purescript/purescript/releases/download/v0.11.7/linux64.tar.gz \
    && echo "$PURESCRIPT_DOWNLOAD_SHA1 linux64.tar.gz" | sha1sum -c - \
    && tar -xvf linux64.tar.gz \
    && rm /opt/linux64.tar.gz
RUN cd /opt \
    && wget https://github.com/purescript/psc-package/releases/download/v0.4.2/linux64.tar.gz \
    && echo "$PSC_PACKAGE_DOWNLOAD_SHA1 linux64.tar.gz" | sha1sum -c - \
    && tar -xvf linux64.tar.gz \
    && rm /opt/linux64.tar.gz

ENV PATH /opt/purescript:$PATH
ENV PATH /opt/psc-package:$PATH

RUN userdel node
RUN useradd -m -s /bin/bash pureuser

WORKDIR /home/pureuser

USER pureuser
