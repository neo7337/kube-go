FROM golang:1.14.2 AS build-env

ENV GO111MODULE=on

ADD ./lib/ /kube-go-app

WORKDIR /kube-go-app

RUN ls -lrt

EXPOSE 9191

CMD ["./main"]