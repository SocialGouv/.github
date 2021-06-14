FROM ghcr.io/socialgouv/docker/dhall:6.22.0@sha256:bfcd1b105d72b981ab7084c697bfc57dca00a4b47c536d5c6af206be631ab09c as dhall_image

FROM alpine:3.13

RUN apk add --update --no-cache \
  bash=~5

COPY --from=dhall_image /usr/local/bin/dhall /usr/local/bin/
COPY --from=dhall_image /usr/local/bin/dhall-to-yaml /usr/local/bin/

COPY .github /.github

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
