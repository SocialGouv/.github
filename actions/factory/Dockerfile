FROM ghcr.io/socialgouv/docker/dhall:6.47.8@sha256:17c011892772485104d4f6d1ee4d597e28e63e524dd6ff5102373ead51537d89 as dhall_image

FROM alpine:3.14

RUN apk add --update --no-cache \
  bash=~5

COPY --from=dhall_image /usr/local/bin/dhall /usr/local/bin/
COPY --from=dhall_image /usr/local/bin/dhall-to-yaml /usr/local/bin/

COPY .github /.github

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
