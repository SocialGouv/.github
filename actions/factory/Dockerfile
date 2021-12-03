FROM ghcr.io/socialgouv/docker/dhall:6.64.2@sha256:9468275cfc34c6ed1bae1c1d89d3a58546fc275f42f3a027d26e991db01b3c6e as dhall_image

FROM alpine:3.15

RUN apk add --update --no-cache \
  bash=~5

COPY --from=dhall_image /usr/local/bin/dhall /usr/local/bin/
COPY --from=dhall_image /usr/local/bin/dhall-to-yaml /usr/local/bin/

COPY .github /.github

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
