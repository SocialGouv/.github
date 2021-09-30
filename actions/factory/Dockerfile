FROM ghcr.io/socialgouv/docker/dhall:6.53.0@sha256:29daeb3ec6112b52824bcccc2ec52124992b03657a5ded0be4bad7de45d60a17 as dhall_image

FROM alpine:3.14

RUN apk add --update --no-cache \
  bash=~5

COPY --from=dhall_image /usr/local/bin/dhall /usr/local/bin/
COPY --from=dhall_image /usr/local/bin/dhall-to-yaml /usr/local/bin/

COPY .github /.github

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
