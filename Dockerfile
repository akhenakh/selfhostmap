FROM caddy:2.10.2-builder AS builder

RUN xcaddy build --with github.com/caddy-dns/cloudflare --replace github.com/protomaps/go-pmtiles=github.com/akhenakh/go-pmtiles@ba46c3093b19c66856d0ca86586cd39e15ee78ec --with github.com/protomaps/go-pmtiles/caddy

FROM caddy:2.10.2

COPY --from=builder /usr/bin/caddy /usr/bin/caddy
COPY Caddyfile /etc/caddy/Caddyfile
ADD htdocs/ /srv/
