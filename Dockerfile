FROM caddy:2.8.4-builder AS builder

RUN xcaddy build --with github.com/caddy-dns/cloudflare --with github.com/protomaps/go-pmtiles/caddy

FROM caddy:2.8.4

COPY --from=builder /usr/bin/caddy /usr/bin/caddy
COPY Caddyfile /etc/caddy/Caddyfile
ADD htdocs/ /srv/
