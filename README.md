# SendGrid Mock API + Inbucket

SendGrid Dev is SengGrid mock API for test your sendgrid emails during development.

[SengGrid Inbucket](https://hub.docker.com/r/ecchochan/sendgrid-dev) is Docker container with SendGrid Mock API + [Inbucket](https://github.com/inbucket/inbucket).

Forked from https://github.com/yKanazawa/sendgrid-dev

## Requirements

- Go 1.16+

## Debug

### Sample with Inbucket (Can work by default)

Run docker-compose

```
docker-compose up -d
```

Send mail by curl

```
curl --request POST \
  --url http://localhost:3030/v3/mail/send \
  --header 'Authorization: Bearer SG.xxxxx' \
  --header 'Content-Type: application/json' \
  --data '{"personalizations": [{
    "to": [{"email": "to@example.com"}]}],
    "from": {"email": "from@example.com"},
    "subject": "Test Subject",
    "content": [{"type": "text/plain", "value": "Test Content"}]
  }'
```

Check with inbucket

http://localhost:9000/

### Sample with MailTrap (with SMTP Auth)

Run SendGrid Mock API

```
export SENDGRID_DEV_API_SERVER :3030
export SENDGRID_DEV_API_KEY=SG.xxxxx
export SENDGRID_DEV_SMTP_SERVER=smtp.mailtrap.io:25
export SENDGRID_DEV_SMTP_USERNAME=mailtrap_username
export SENDGRID_DEV_SMTP_PASSWORD=mailtrap_password
go run main.go
```

Send mail by curl

```
curl --request POST \
  --url http://localhost:3030/v3/mail/send \
  --header 'Authorization: Bearer SG.xxxxx' \
  --header 'Content-Type: application/json' \
  --data '{"personalizations": [{
    "to": [{"email": "to@example.com"}]}],
    "from": {"email": "from@example.com"},
    "subject": "Test Subject",
    "content": [{"type": "text/plain", "value": "Test Content"}]
  }'
```

Check with mailtrap Inbox

https://mailtrap.io/inboxes

## Test

```
go test
```

## Build

### x86_64

```bash
env GOOS=linux GOARCH=amd64 go build -o sendgrid-dev_x86_64 main.go
```

### arm64

```bash
env GOOS=linux GOARCH=arm64 go build -o sendgrid-dev_aarch64 main.go
```

### Docker

```bash
docker buildx build \
  --push \
  -f Dockerfile \
  -t ecchochan/sendgrid-dev:v0.9.1 \
  --platform linux/arm64,linux/amd64 \
  .

```
