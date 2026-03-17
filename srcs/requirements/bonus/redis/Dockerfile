FROM alpine:3.22.3

RUN apk add --no-cache redis

EXPOSE 6379

CMD ["redis-server", "--bind", "0.0.0.0", "--protected-mode", "no", "--appendonly", "yes"]
