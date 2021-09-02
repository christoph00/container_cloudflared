FROM docker.io/library/alpine

ARG ARCH
RUN \
    CVERSION="latest/download" \
    && apk add --no-cache libc6-compat yq \
    && wget -O /usr/local/bin/cloudflared https://github.com/cloudflare/cloudflared/releases/$CVERSION/cloudflared-linux-$ARCH && chmod +x /usr/local/bin/cloudflared

RUN cloudflared -v

ENTRYPOINT ["/usr/local/bin/cloudflared"]
