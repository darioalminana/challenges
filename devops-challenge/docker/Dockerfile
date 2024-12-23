FROM golang:1.23-alpine AS builder
WORKDIR /app
COPY ./app/go* ./
RUN go mod download
COPY . .
RUN go build -o main main.go 

FROM alpine:3.21.0
WORKDIR /app
COPY --from=builder /app/main .
CMD [ "./main" ]