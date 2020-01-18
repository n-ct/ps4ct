
FROM golang:1.11 as builder


RUN git clone --depth 1 https://github.com/SSLMate/certspotter.git /go/src/software.sslmate.com/src/certspotter/

WORKDIR /go/src/software.sslmate.com/src/certspotter/cmd/certspotter

RUN go get ./...

RUN go install

WORKDIR /root

#CMD certspotter


