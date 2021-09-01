FROM ghcr.io/socialgouv/docker/dhall:6.47.3@sha256:f7312d3857c9063263d05444405552eb2a29d2115385fcbfb6fdd810f56b0d73 as dhall_image

FROM alpine:3.14

RUN apk add --update --no-cache \
  bash=~5

COPY --from=dhall_image /usr/local/bin/dhall /usr/local/bin/
COPY --from=dhall_image /usr/local/bin/dhall-to-yaml /usr/local/bin/

COPY .github /.github

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
