###
# Build stage
###
FROM docker.io/golang:1.14.3-alpine as build
# APP_VERSION will be inserted into binary at build time by the go linker
ARG APP_VERSION
WORKDIR /app
# Fail if build variable APP_VERSION was not set
RUN if [ -z "$APP_VERSION" ]; then exit 1; fi
# Copy list of dependencies
COPY go.mod go.sum ./
# Download dependencies
RUN go mod download
# Copy source code
COPY server.go ./
# Compile application
RUN CGO_ENABLED=0 go build -o server -ldflags "-X 'main.Version=$APP_VERSION'" server.go


###
# Final stage
###
FROM scratch
# Copy binary from build stage
COPY --from=build /app/server /server
ENTRYPOINT [ "/server", "-a", "0.0.0.0:8080" ]
