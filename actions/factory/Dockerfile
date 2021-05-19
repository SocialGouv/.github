FROM ghcr.io/socialgouv/docker/dhall:6.11.1@sha256:d7b875b955204d2fd8f2c9eba8765951109f8ebd3b7b79f5639ce01fd0ca8d7b as dhall_image

FROM alpine:3.13

RUN apk add --update --no-cache \
  bash=~5

COPY --from=dhall_image /usr/local/bin/dhall /usr/local/bin/
COPY --from=dhall_image /usr/local/bin/dhall-to-yaml /usr/local/bin/

COPY .github /.github

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
