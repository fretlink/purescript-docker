FROM node:9

MAINTAINER Risto Stevcev
ENV PURESCRIPT_DOWNLOAD_SHA1 08d4839f2800a6fdb398ec45b7182eada112ea89
ENV PSC_PACKAGE_DOWNLOAD_SHA1 bdf25acc5b4397bd03fd1da024896c5f33af85ce

RUN yarn global add pulp@12.3.0

RUN cd /opt \
    && wget https://github.com/purescript/purescript/releases/download/v0.12.0/linux64.tar.gz \
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
