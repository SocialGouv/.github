FROM ghcr.io/socialgouv/docker/dhall:6.20.1@sha256:f75c1122c6069891ae838908d171d2f7018a49c905d2949c06346bdedd1f9685 as dhall_image

FROM alpine:3.13

RUN apk add --update --no-cache \
  bash=~5

COPY --from=dhall_image /usr/local/bin/dhall /usr/local/bin/
COPY --from=dhall_image /usr/local/bin/dhall-to-yaml /usr/local/bin/

COPY .github /.github

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
