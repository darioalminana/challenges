#! /bin/bash
sudo apt-get update
sudo apt-get install -y docker.io
sudo cd /home/ubuntu
sudo git clone git@github.com:darioalminana/challenge-devops-challenge.git

cat << __EOF__ > ./dockerfile
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
__EOF__

cat << __EOF__ > ./docker-compose.yml
version: '3.9'
services:
  web:
    build: .
    container_name: "go-app"
    ports:
      - "9200:8080"
__EOF__

sudo docker-compose up -d --build