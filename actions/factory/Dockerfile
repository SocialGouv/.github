FROM ghcr.io/socialgouv/docker/dhall:6.24.0@sha256:65375886e5b13ef14ae1deabc2664f676f5f8abf22671bde6fe0826e361f0bdc as dhall_image

FROM alpine:3.14

RUN apk add --update --no-cache \
  bash=~5

COPY --from=dhall_image /usr/local/bin/dhall /usr/local/bin/
COPY --from=dhall_image /usr/local/bin/dhall-to-yaml /usr/local/bin/

COPY .github /.github

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
