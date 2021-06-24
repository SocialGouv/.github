FROM ghcr.io/socialgouv/docker/dhall:6.26.1@sha256:4ad5f66915d9824752c038f8d3570a8a8e4c948b0462a737cfcaa29f8e59563e as dhall_image

FROM alpine:3.14

RUN apk add --update --no-cache \
  bash=~5

COPY --from=dhall_image /usr/local/bin/dhall /usr/local/bin/
COPY --from=dhall_image /usr/local/bin/dhall-to-yaml /usr/local/bin/

COPY .github /.github

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
