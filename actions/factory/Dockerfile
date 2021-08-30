FROM ghcr.io/socialgouv/docker/dhall:6.47.0@sha256:31d6fbe2611ccef40b669fc30d6627a418075b6e526aaa851ec319b9d5986782 as dhall_image

FROM alpine:3.14

RUN apk add --update --no-cache \
  bash=~5

COPY --from=dhall_image /usr/local/bin/dhall /usr/local/bin/
COPY --from=dhall_image /usr/local/bin/dhall-to-yaml /usr/local/bin/

COPY .github /.github

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
