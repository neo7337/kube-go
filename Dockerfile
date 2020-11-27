FROM golang:1.14.2 AS build-env

ENV GO111MODULE=on

ADD . /kube-go-app

WORKDIR /kube-go-app

RUN go mod download

COPY . .

RUN go build -o main main.go

EXPOSE 9191

CMD ["./main"]