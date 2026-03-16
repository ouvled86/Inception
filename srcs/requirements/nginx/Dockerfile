FROM alpine:3.22.3

RUN apk add --no-cache \
    nginx \
    openssl \
    gettext

RUN mkdir -p /etc/nginx/ssl

COPY ./conf/nginx.conf /etc/nginx/http.d/default.conf.template
COPY ./tools/entrypoint.sh /usr/local/bin/entrypoint.sh

RUN chmod +x /usr/local/bin/entrypoint.sh

EXPOSE 443

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
CMD ["nginx", "-g", "daemon off;"]
