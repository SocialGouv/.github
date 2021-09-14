FROM ghcr.io/socialgouv/docker/dhall:6.47.9@sha256:e38f4c6237674f54840367a81901b05592416654fc3b7f36baa6346eea830a6a as dhall_image

FROM alpine:3.14

RUN apk add --update --no-cache \
  bash=~5

COPY --from=dhall_image /usr/local/bin/dhall /usr/local/bin/
COPY --from=dhall_image /usr/local/bin/dhall-to-yaml /usr/local/bin/

COPY .github /.github

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
