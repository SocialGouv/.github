FROM ghcr.io/socialgouv/docker/dhall:7.1.0@sha256:e194a5f0a379b8fae7715e7d9bbc08a7aa36a5a4e12d09161d5b54b0eedf07bc as dhall_image

FROM alpine:3.17

RUN apk add --update --no-cache \
  bash=~5

COPY --from=dhall_image /usr/local/bin/dhall /usr/local/bin/
COPY --from=dhall_image /usr/local/bin/dhall-to-yaml /usr/local/bin/

COPY .github /.github

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
