FROM ghcr.io/socialgouv/docker/dhall:6.60.0@sha256:98923ff211d239cb64ee7db19ab2b7c04b8bacb11c7b1f1f52bd7f2e521fb4d8 as dhall_image

FROM alpine:3.14

RUN apk add --update --no-cache \
  bash=~5

COPY --from=dhall_image /usr/local/bin/dhall /usr/local/bin/
COPY --from=dhall_image /usr/local/bin/dhall-to-yaml /usr/local/bin/

COPY .github /.github

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
