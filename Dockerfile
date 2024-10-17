FROM caddy:2.8.4-builder AS builder

RUN xcaddy build --with github.com/caddy-dns/cloudflare --with github.com/protomaps/go-pmtiles/caddy@846d83e4b199344284400809c73d08fe12d0722e

FROM caddy:2.8.4

COPY --from=builder /usr/bin/caddy /usr/bin/caddy
COPY Caddyfile /etc/caddy/Caddyfile
ADD htdocs/ /srv/
