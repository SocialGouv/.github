FROM ghcr.io/socialgouv/docker/dhall:6.59.0@sha256:012fae0b82f1042388c618751fdfc8dae14f3cc2dd4b2cac53d5d14de1f39dbe as dhall_image

FROM alpine:3.14

RUN apk add --update --no-cache \
  bash=~5

COPY --from=dhall_image /usr/local/bin/dhall /usr/local/bin/
COPY --from=dhall_image /usr/local/bin/dhall-to-yaml /usr/local/bin/

COPY .github /.github

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
