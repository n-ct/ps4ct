FROM golang:1.12

RUN apt update -qq
RUN apt install -y default-mysql-client-core lsof vim

ENV GO111MODULE=on MYSQL_HOST=mysql MYSQL_USER=test MYSQL_PASSWORD=zaphod MYSQL_ROOT_PASSWORD=beeblebrox

# install trillian dependencies
WORKDIR /go/src/github.com/zorawar87/trillian
COPY trillian/go.mod trillian/go.sum ./
RUN go mod download
ADD trillian ./

# install ct personality depencies
WORKDIR /go/src/github.com/zorawar87/certificate-transparency-go
COPY certificate-transparency-go/go.mod certificate-transparency-go/go.sum ./
RUN go mod download
ADD certificate-transparency-go ./

# copy configuration files
COPY config/* /

ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["bash"]
