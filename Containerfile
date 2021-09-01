ARG ARCH
FROM docker.io/library/golang:alpine as gobuild

ARG GOARCH
ARG GOARM

RUN go get -v github.com/cloudflare/cloudflared/cmd/cloudflared

WORKDIR /go/src/github.com/cloudflare/cloudflared/cmd/cloudflared

RUN GOARCH=${GOARCH} GOARM=${GOARM} go build ./

FROM docker.io/library/alpine

ENV DNS1 1.1.1.1
ENV DNS2 1.0.0.1

RUN apk add --no-cache ca-certificates bind-tools; \
    rm -rf /var/cache/apk/*;

COPY --from=gobuild /go/src/github.com/cloudflare/cloudflared/cmd/cloudflared/cloudflared /usr/local/bin/cloudflared

CMD ["/usr/local/bin/cloudflared"]
