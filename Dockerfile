# Build stage
FROM golang:alpine AS build-env
ADD . /src
RUN cd /src && CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -o app

# Final stage
FROM alpine:latest
# Install CA certificates
RUN apk --no-cache add ca-certificates
COPY --from=build-env /src/app /
ENTRYPOINT ["/app"]
