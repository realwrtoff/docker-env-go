FROM centos:centos7
RUN yum install -y kde-l10n-Chinese && yum reinstall -y glibc-common && localedef -c -f UTF-8 -i zh_CN zh_CN.utf8 
RUN yum install -y epel-release
RUN yum install -y docker-io
RUN yum install -y go
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

# grpc support
RUN yum install -y unzip
RUN curl -OL https://github.com/protocolbuffers/protobuf/releases/download/v3.10.0/protoc-3.10.0-linux-x86_64.zip
RUN unzip protoc-3.10.0-linux-x86_64.zip
RUN export GOPROXY=https://goproxy.cn && \
    mkdir -p /src/google.golang.org/grpc && \
    cd /src/google.golang.org/grpc && \
    export GOPATH=/ && \
    export GO111MODULE=on && \
    go mod init && \
    go get -u google.golang.org/grpc && \
    go get -u github.com/golang/protobuf/protoc-gen-go

ENV LANG=zh_CN.UTF-8
ENV LANGUAGE=zh_CN:zh
ENV LC_ALL=zh_CN.UTF-8
