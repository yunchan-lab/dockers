FROM alpine

RUN apk update && apk add openssl && rm -rf /var/cache/apk/*

WORKDIR /keys
RUN if [ ! -f /keys/mongodb-keyfile ]; \
        then openssl rand -base64 756 > mongodb-keyfile; \
    fi \
    && chown 999:999 mongodb-keyfile && chmod 400 mongodb-keyfile