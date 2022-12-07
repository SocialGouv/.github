FROM ghcr.io/socialgouv/docker/dhall:7.3.0@sha256:67e57649beffce1f161e2275c86dc586c5c20f643cdc47b24580dafaa0f7ddc3 as dhall_image

FROM alpine:3.17

RUN apk add --update --no-cache \
  bash=~5

COPY --from=dhall_image /usr/local/bin/dhall /usr/local/bin/
COPY --from=dhall_image /usr/local/bin/dhall-to-yaml /usr/local/bin/

COPY .github /.github

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
