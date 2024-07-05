FROM golang:1.22 AS builder

ENV CGO_ENABLED 0

ENV GOOS linux

ENV GOARCH=amd64

WORKDIR /app

COPY go.mod go.sum ./

RUN go mod download

COPY *.go ./

RUN go build -o /my_doc



FROM alpine

WORKDIR /my_doc

COPY --from=builder /my_doc .

COPY tracker.db .

CMD ["./my_doc"]