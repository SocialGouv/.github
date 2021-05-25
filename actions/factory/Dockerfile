FROM ghcr.io/socialgouv/docker/dhall:6.13.0@sha256:8dd8f00f2a7511fb0413c0f3ad6a8651c106640e9e90c4717e76f76d516b6e1d as dhall_image

FROM alpine:3.13

RUN apk add --update --no-cache \
  bash=~5

COPY --from=dhall_image /usr/local/bin/dhall /usr/local/bin/
COPY --from=dhall_image /usr/local/bin/dhall-to-yaml /usr/local/bin/

COPY .github /.github

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
