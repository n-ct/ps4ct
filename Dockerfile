FROM golang:1.11 

RUN apt update -qq
RUN apt install -y default-mysql-client-core lsof vim

ENV GO111MODULE=on MYSQL_HOST=mysql MYSQL_USER=test MYSQL_PASSWORD=zaphod MYSQL_ROOT_PASSWORD=beeblebrox

# install trillian
WORKDIR /go/src/github.com/zorawar87/trillian
COPY trillian/go.mod trillian/go.sum ./
RUN go mod download

COPY trillian/* ./

COPY config/docker-entrypoint.sh config/signer.cfg config/server.cfg /

# install ct personality
WORKDIR /go/src/github.com/zorawar87/certificate-transparency-go
COPY certificate-transparency-go/go.mod certificate-transparency-go/go.sum ./
RUN go mod download
COPY certificate-transparency-go/* ./

ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["bash"]
