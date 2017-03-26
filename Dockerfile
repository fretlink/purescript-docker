FROM node:4

MAINTAINER Risto Stevcev

ENV PURESCRIPT_DOWNLOAD_SHA1 f1a3d36fba9d9e2783173f6a050e097e107da530

RUN npm install -g bower pulp

RUN cd /opt \
    && wget https://github.com/purescript/purescript/releases/download/v0.10.7/linux64.tar.gz \
    && echo "$PURESCRIPT_DOWNLOAD_SHA1 linux64.tar.gz" | sha1sum -c - \
    && tar -xvf linux64.tar.gz \
    && rm /opt/linux64.tar.gz

ENV PATH /opt/purescript:$PATH

RUN userdel node
RUN useradd -m -s /bin/bash pureuser

WORKDIR /home/pureuser

USER pureuser

RUN mkdir tmp && cd tmp && pulp init

CMD cd tmp && pulp psci
