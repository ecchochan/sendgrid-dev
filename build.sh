docker buildx build \
  --push \
  -f Dockerfile \
  -t ecchochan/sendgrid-dev:v0.9.1 \
  --platform linux/arm64,linux/amd64 \
  .
