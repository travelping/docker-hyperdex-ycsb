FROM ubuntu:14.04

MAINTAINER umatomba@gmail.com

USER root

RUN apt-get update && apt-get install -y wget
RUN wget -O - http://ubuntu.hyperdex.org/hyperdex.gpg.key | apt-key add -
RUN echo "deb [arch=amd64] http://ubuntu.hyperdex.org trusty main" > /etc/apt/sources.list.d/hyperdex.list
RUN apt-get update && apt-get install -y openjdk-6-jdk build-essential python2.7 python2.7-dev python-pyparsing python-setuptools python-argparse cython swig2.0 autoconf automake autoconf-archive libtool pkg-config gperf

RUN mkdir /hyperdex_build
WORKDIR /hyperdex_build
RUN wget https://google-glog.googlecode.com/files/glog-0.3.3.tar.gz && tar xzf glog-0.3.3.tar.gz
WORKDIR /hyperdex_build/glog-0.3.3
RUN autoreconf -i;./configure && make && make install

WORKDIR /hyperdex_build
RUN wget http://rpm5.org/files/popt/popt-1.16.tar.gz && tar xzf popt-1.16.tar.gz
WORKDIR /hyperdex_build/popt-1.16
RUN autoreconf -i;./configure && make && make install

ENV PKG_CONFIG_PATH /usr/local/lib/pkgconfig/

WORKDIR /hyperdex_build
RUN wget http://hyperdex.org/src/libpo6-0.6.0.tar.gz && tar xzf libpo6-0.6.0.tar.gz
WORKDIR /hyperdex_build/libpo6-0.6.0
RUN autoreconf -i;./configure && make && make install

WORKDIR /hyperdex_build
RUN wget http://hyperdex.org/src/libe-0.9.0.tar.gz && tar xzf libe-0.9.0.tar.gz
WORKDIR /hyperdex_build/libe-0.9.0
RUN autoreconf -i;./configure && make && make install

WORKDIR /hyperdex_build
RUN wget http://hyperdex.org/src/busybee-0.5.2.tar.gz && tar xzf busybee-0.5.2.tar.gz
WORKDIR /hyperdex_build/busybee-0.5.2
RUN autoreconf -i;./configure && make && make install

WORKDIR /hyperdex_build
RUN wget http://hyperdex.org/src/hyperleveldb-1.2.2.tar.gz && tar xzf hyperleveldb-1.2.2.tar.gz
WORKDIR /hyperdex_build/hyperleveldb-1.2.2
RUN autoreconf -i;./configure && make && make install

WORKDIR /hyperdex_build
RUN wget http://hyperdex.org/src/replicant-0.6.4.tar.gz && tar xzf replicant-0.6.4.tar.gz
WORKDIR /hyperdex_build/replicant-0.6.4
RUN autoreconf -i;./configure && make && make install

WORKDIR /hyperdex_build
RUN wget http://hyperdex.org/src/libtreadstone-0.1.0.tar.gz && tar xzf libtreadstone-0.1.0.tar.gz
WORKDIR /hyperdex_build/libtreadstone-0.1.0
RUN autoreconf -i;./configure && make && make install

WORKDIR /hyperdex_build
RUN wget https://download.libsodium.org/libsodium/releases/libsodium-0.7.0.tar.gz && tar xzf libsodium-0.7.0.tar.gz
WORKDIR /hyperdex_build/libsodium-0.7.0
RUN autoreconf -i;./configure && make && make install

WORKDIR /hyperdex_build
RUN wget http://hyperdex.org/src/libmacaroons-0.2.0.tar.gz && tar xzf libmacaroons-0.2.0.tar.gz
WORKDIR /hyperdex_build/libmacaroons-0.2.0
RUN autoreconf -i;./configure && make && make install

WORKDIR /hyperdex_build
RUN wget https://github.com/downloads/brianfrankcooper/YCSB/ycsb-0.1.4.tar.gz && tar zxf ycsb-0.1.4.tar.gz

ENV CLASSPATH $CLASSPATH:/hyperdex_build/ycsb-0.1.4/core/lib/core-0.1.4.jar

WORKDIR /hyperdex_build
RUN wget http://hyperdex.org/src/hyperdex-1.6.0.tar.gz && tar xzf hyperdex-1.6.0.tar.gz
WORKDIR /hyperdex_build/hyperdex-1.6.0
RUN autoreconf -i;./configure --enable-java-bindings --enable-ycsb && make && make install

ENV CLASSPATH $CLASSPATH:/hyperdex_build/hyperdex-1.6.0/bindings/java/org.hyperdex.client-1.6.0.jar:/hyperdex_build/hyperdex-1.6.0/bindings/java/org.hyperdex.ycsb-1.6.0.jar

RUN ldconfig

VOLUME /hyperdex_build/ycsb-0.1.4

CMD /bin/bash
