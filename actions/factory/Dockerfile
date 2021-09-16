FROM ghcr.io/socialgouv/docker/dhall:6.49.0@sha256:a46ae67ce072fa8eee9927b91f1a27a09a6830a1aa6a97580d3c3ee92fa6eb8d as dhall_image

FROM alpine:3.14

RUN apk add --update --no-cache \
  bash=~5

COPY --from=dhall_image /usr/local/bin/dhall /usr/local/bin/
COPY --from=dhall_image /usr/local/bin/dhall-to-yaml /usr/local/bin/

COPY .github /.github

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
