FROM caddy:2.10.0-builder AS builder

RUN xcaddy build --with github.com/caddy-dns/cloudflare --with github.com/protomaps/go-pmtiles/caddy@9a400a68d039dfa71e1706f154139558cbd1999f

FROM caddy:2.10.0

COPY --from=builder /usr/bin/caddy /usr/bin/caddy
COPY Caddyfile /etc/caddy/Caddyfile
ADD htdocs/ /srv/
