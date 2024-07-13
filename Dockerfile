ARG ALPINE_VERSION=3.19

# stage 1: build go app
FROM golang:1.22.3-alpine${ALPINE_VERSION} AS builder

WORKDIR /build-stage

COPY go.mod go.sum ./

RUN go mod download

COPY . .

RUN go build main.go

# stage 2: production image
FROM alpine:${ALPINE_VERSION}

WORKDIR /app

COPY --from=builder /build-stage/main .

CMD [ "./main" ]
