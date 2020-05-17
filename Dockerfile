FROM centos:centos7

RUN yum install -y kde-l10n-Chinese && yum reinstall -y glibc-common && localedef -c -f UTF-8 -i zh_CN zh_CN.utf8

RUN yum install -y epel-release
RUN yum install -y docker-io
RUN yum install -y make

# behave support
RUN yum install -y python36 python36-setuptools python36-pip
RUN pip3 install --upgrade pip -i http://mirrors.aliyun.com/pypi/simple/ --trusted-host mirrors.aliyun.com
RUN pip3 install requests -i http://mirrors.aliyun.com/pypi/simple/ --trusted-host mirrors.aliyun.com
RUN pip3 install flask -i http://mirrors.aliyun.com/pypi/simple/ --trusted-host mirrors.aliyun.com
RUN pip3 install redis -i http://mirrors.aliyun.com/pypi/simple/ --trusted-host mirrors.aliyun.com
RUN pip3 install pymongo -i http://mirrors.aliyun.com/pypi/simple/ --trusted-host mirrors.aliyun.com
RUN pip3 install behave -i http://mirrors.aliyun.com/pypi/simple/ --trusted-host mirrors.aliyun.com
RUN pip3 install pyhamcrest -i http://mirrors.aliyun.com/pypi/simple/ --trusted-host mirrors.aliyun.com
RUN pip3 install pymysql -i http://mirrors.aliyun.com/pypi/simple/ --trusted-host mirrors.aliyun.com
RUN pip3 install cryptography -i http://mirrors.aliyun.com/pypi/simple/ --trusted-host mirrors.aliyun.com
RUN pip3 install grpcio grpcio-tools -i http://mirrors.aliyun.com/pypi/simple/ --trusted-host mirrors.aliyun.com

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

RUN yum install -y git
RUN yum install -y gcc
