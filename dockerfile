# Builder stage
FROM golang:1.23-alpine AS builder
ENV CGO_ENABLED=0 GOOS=linux GOARCH=amd64
WORKDIR /app
COPY go.mod go.sum ./
RUN go mod download
COPY . .
RUN go build -o datetime-api .

# Deployment Stage
FROM scratch
COPY --from=builder /app/datetime-api /datetime-api
EXPOSE 8080
ENTRYPOINT ["/datetime-api"]
