FROM ghcr.io/socialgouv/docker/dhall:6.51.1@sha256:463d7c15813384c4ac6dc1a273526e7a024f3738615f0aa293ea8b0ab49b98cf as dhall_image

FROM alpine:3.14

RUN apk add --update --no-cache \
  bash=~5

COPY --from=dhall_image /usr/local/bin/dhall /usr/local/bin/
COPY --from=dhall_image /usr/local/bin/dhall-to-yaml /usr/local/bin/

COPY .github /.github

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
