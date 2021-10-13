FROM ghcr.io/socialgouv/docker/dhall:6.58.1@sha256:a2e02fc8be5dfc961209792c6754f0baae805670c0e3084da9340d2f9a809294 as dhall_image

FROM alpine:3.14

RUN apk add --update --no-cache \
  bash=~5

COPY --from=dhall_image /usr/local/bin/dhall /usr/local/bin/
COPY --from=dhall_image /usr/local/bin/dhall-to-yaml /usr/local/bin/

COPY .github /.github

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
