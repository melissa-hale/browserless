FROM alpine:latest AS parallel

RUN apk add --no-cache parallel

FROM caddy:latest AS caddy

COPY Caddyfile ./

RUN caddy fmt --overwrite Caddyfile

FROM browserless/chrome:1-chrome-stable

ENV ENABLE_DEBUGGER=true
ENV DEBUG=browserless:*
ENV PRINT_NETWORK_INFO=true

COPY --from=caddy /srv/Caddyfile ./

COPY --from=caddy /usr/bin/caddy /usr/bin/caddy

COPY --from=parallel /usr/bin/parallel /usr/bin/parallel

COPY --chmod=755 scripts/* ./

ENTRYPOINT ["/bin/sh"]

CMD ["start.sh"]
