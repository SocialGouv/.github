FROM ghcr.io/socialgouv/docker/dhall:6.50.0@sha256:185b0367e1e912b49fcf4d5737b20b703de489f28bed2017875b7ee74a3e6e5a as dhall_image

FROM alpine:3.14

RUN apk add --update --no-cache \
  bash=~5

COPY --from=dhall_image /usr/local/bin/dhall /usr/local/bin/
COPY --from=dhall_image /usr/local/bin/dhall-to-yaml /usr/local/bin/

COPY .github /.github

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
