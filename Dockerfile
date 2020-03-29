FROM centos:centos7

RUN yum install -y kde-l10n-Chinese && yum reinstall -y glibc-common && localedef -c -f UTF-8 -i zh_CN zh_CN.utf8

ENV LANG=zh_CN.UTF-8
ENV LANGUAGE=zh_CN:zh
ENV LC_ALL=zh_CN.UTF-8

RUN yum install -y epel-release
RUN yum install -y docker-io
RUN yum install -y make

# behave support
RUN yum install -y python36 python36-setuptools python36-pip
RUN pip3 install --upgrade pip
RUN pip3 install requests
RUN pip3 install flask
RUN pip3 install redis
RUN pip3 install pymongo
RUN pip3 install behave
RUN pip3 install pyhamcrest
RUN pip3 install pymysql
RUN pip3 install cryptography
RUN pip3 install grpcio grpcio-tools

# golang
ENV GOPROXY=https://goproxy.io
RUN curl -OL https://dl.google.com/go/go1.14.1.linux-amd64.tar.gz && \
    tar -xzvf go1.14.1.linux-amd64.tar.gz && mv go /usr/local
ENV PATH=$PATH:/usr/local/go/bin
ENV GOROOT=/usr/local/go

# grpc support
RUN yum install -y unzip
RUN curl -OL https://github.com/protocolbuffers/protobuf/releases/download/v3.10.0/protoc-3.10.0-linux-x86_64.zip
RUN unzip protoc-3.10.0-linux-x86_64.zip
RUN go version

RUN mkdir -p /src/google.golang.org/grpc && \
    cd /src/google.golang.org/grpc && \
    export GOPATH=/ && \
    export GO111MODULE=on && \
    go get -u google.golang.org/grpc && \
    go get -u github.com/golang/protobuf/protoc-gen-go