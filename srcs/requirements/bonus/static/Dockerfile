FROM alpine:3.22.3

RUN apk add --no-cache busybox-extras

WORKDIR /var/www/html

COPY ./tools/static/ ./

EXPOSE 80

CMD ["httpd", "-f", "-p", "80", "-h", "/var/www/html"]
