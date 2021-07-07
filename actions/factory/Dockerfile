FROM ghcr.io/socialgouv/docker/dhall:6.26.5@sha256:74a79c9e5dd52e98ac3a635ffa24a75d3b753d7d2b2b05b340b0c296bb6845b7 as dhall_image

FROM alpine:3.14

RUN apk add --update --no-cache \
  bash=~5

COPY --from=dhall_image /usr/local/bin/dhall /usr/local/bin/
COPY --from=dhall_image /usr/local/bin/dhall-to-yaml /usr/local/bin/

COPY .github /.github

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
