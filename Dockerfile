FROM golang:1.22-alpine AS builder
WORKDIR /app
COPY go.mod ./
COPY *.go ./
RUN go build -o /go-health-api

FROM alpine:latest  
WORKDIR /root/
COPY --from=builder /go-health-api ./
EXPOSE 8080
CMD ["./go-health-api"]