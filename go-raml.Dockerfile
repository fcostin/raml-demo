FROM golang:1.11.4-alpine3.8

RUN apk add --no-cache git make

ENV GOPATH /go

RUN mkdir /tmp/work
WORKDIR /tmp/work


RUN go get -u github.com/Jumpscale/go-raml
RUN go get -u github.com/jteeuwen/go-bindata/...
RUN CGO_ENABLED=0 go build github.com/jteeuwen/go-bindata/...

ENV PATH "$PATH":"$GOPATH/bin"
RUN ls "$GOPATH/bin"

WORKDIR $GOPATH/src/github.com/Jumpscale/go-raml
RUN make install

WORKDIR /tmp/work
COPY fruitmarket.raml ./fruitmarket.raml

RUN go-raml server -l go --dir "$GOPATH"/src/fruit.example.com/fruitmarket --ramlfile fruitmarket.raml --import-path fruit.example.com/fruitmarket
