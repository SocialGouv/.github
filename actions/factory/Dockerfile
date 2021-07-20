FROM ghcr.io/socialgouv/docker/dhall:6.33.0@sha256:f0b5b06410b795f6e1d9f5cc05b918d64d9f83cc558d17c63c851e657cc694c2 as dhall_image

FROM alpine:3.14

RUN apk add --update --no-cache \
  bash=~5

COPY --from=dhall_image /usr/local/bin/dhall /usr/local/bin/
COPY --from=dhall_image /usr/local/bin/dhall-to-yaml /usr/local/bin/

COPY .github /.github

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
