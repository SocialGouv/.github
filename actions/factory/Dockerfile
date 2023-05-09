FROM ghcr.io/socialgouv/docker/dhall:7.6.1@sha256:d9dd9da65d7adc6b6aded5427b3d843e24fdff6fed12c27b6f6a67f958c28619 as dhall_image

FROM alpine:3.17

RUN apk add --update --no-cache \
  bash=~5

COPY --from=dhall_image /usr/local/bin/dhall /usr/local/bin/
COPY --from=dhall_image /usr/local/bin/dhall-to-yaml /usr/local/bin/

COPY .github /.github

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
