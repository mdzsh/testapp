# Build stage
FROM golang:alpine AS build-env
WORKDIR /src
COPY . .
RUN go mod init goapp
RUN go mod download
RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -o app

# Final stage
FROM alpine:latest
RUN apk --no-cache add ca-certificates
COPY --from=build-env /src/app /
ENTRYPOINT ["/app"]
