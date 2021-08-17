FROM ghcr.io/socialgouv/docker/dhall:6.41.0@sha256:a9a3590d4bff171ec908cbecfef0640983a111336ede5cccd945b0a942e8a3f0 as dhall_image

FROM alpine:3.14

RUN apk add --update --no-cache \
  bash=~5

COPY --from=dhall_image /usr/local/bin/dhall /usr/local/bin/
COPY --from=dhall_image /usr/local/bin/dhall-to-yaml /usr/local/bin/

COPY .github /.github

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
