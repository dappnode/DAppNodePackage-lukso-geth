ARG UPSTREAM_VERSION

FROM ethereum/client-go:${UPSTREAM_VERSION}

COPY /security /security
COPY /config /config
COPY entrypoint.sh /usr/local/bin/entrypoint.sh

RUN apk update && apk add curl && \ 
    chmod +x /usr/local/bin/entrypoint.sh

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]