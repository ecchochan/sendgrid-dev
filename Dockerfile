FROM golang:1.21-alpine AS builder

# For docker buildx multi-platform building
ARG TARGETARCH

# Create and change to the app directory.
WORKDIR /app

# Retrieve application dependencies.
# This allows the container build to reuse cached dependencies.
# Expecting to copy go.mod and if present go.sum.
COPY go.* ./
RUN go mod download

# Copy local code to the container image.
COPY . ./

RUN apk --no-cache add gcc g++ sqlite
RUN env \
  CGO_ENABLED=1 \
  GOOS=linux \
  GOARCH=${TARGETARCH} go build -a -installsuffix cgo -o server

FROM alpine:latest
RUN apk --no-cache add ca-certificates sqlite
COPY --from=builder /app/server /app/server

CMD ["/app/server"]
