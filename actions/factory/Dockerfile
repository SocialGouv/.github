FROM ghcr.io/socialgouv/docker/dhall:6.51.0@sha256:8019baaffd3c881ca865c49dc3cafb3931b66c0e7a7d59bc6d8b61a49d5fe7ff as dhall_image

FROM alpine:3.14

RUN apk add --update --no-cache \
  bash=~5

COPY --from=dhall_image /usr/local/bin/dhall /usr/local/bin/
COPY --from=dhall_image /usr/local/bin/dhall-to-yaml /usr/local/bin/

COPY .github /.github

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
