FROM ghcr.io/socialgouv/docker/dhall:6.69.0@sha256:e60d7ddeaa97bb54093df6d79410ee4bd4e5ad249fa791bacb74cdb46839fd63 as dhall_image

FROM alpine:3.15

RUN apk add --update --no-cache \
  bash=~5

COPY --from=dhall_image /usr/local/bin/dhall /usr/local/bin/
COPY --from=dhall_image /usr/local/bin/dhall-to-yaml /usr/local/bin/

COPY .github /.github

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
