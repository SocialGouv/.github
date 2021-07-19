FROM ghcr.io/socialgouv/docker/dhall:6.32.2@sha256:8e5f1b0b6dfe80e87ab79161fe4ea1afc1cc9d9779015378646deb30b8e872c4 as dhall_image

FROM alpine:3.14

RUN apk add --update --no-cache \
  bash=~5

COPY --from=dhall_image /usr/local/bin/dhall /usr/local/bin/
COPY --from=dhall_image /usr/local/bin/dhall-to-yaml /usr/local/bin/

COPY .github /.github

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
