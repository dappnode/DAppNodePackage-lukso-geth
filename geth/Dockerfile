ARG UPSTREAM_VERSION

FROM ethereum/client-go:${UPSTREAM_VERSION}

COPY /security /security
COPY entrypoint.sh /usr/local/bin/entrypoint.sh

RUN apk update && apk add curl && \ 
    chmod +x /usr/local/bin/entrypoint.sh

RUN mkdir /config

# Get Lukso genesis for Geth
RUN curl -L https://raw.githubusercontent.com/lukso-network/network-configs/main/mainnet/shared/genesis_42.json -o /config/genesis.json

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]