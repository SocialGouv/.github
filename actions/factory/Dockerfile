FROM ghcr.io/socialgouv/docker/dhall:6.9.0@sha256:9a0c601c5b90e99b14b7365a0a62d8cf3e8daee419183a9459b25150eada08a5 as dhall_image

FROM alpine:3.13

RUN apk add --update --no-cache \
  bash=~5

COPY --from=dhall_image /usr/local/bin/dhall /usr/local/bin/
COPY --from=dhall_image /usr/local/bin/dhall-to-yaml /usr/local/bin/

COPY .github /.github

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
