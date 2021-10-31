FROM ghcr.io/socialgouv/docker/dhall:6.58.3@sha256:df91f5e530ebedd66b6d9189b2fb7b40beb0174e26460a4bb74f442e7633183f as dhall_image

FROM alpine:3.14

RUN apk add --update --no-cache \
  bash=~5

COPY --from=dhall_image /usr/local/bin/dhall /usr/local/bin/
COPY --from=dhall_image /usr/local/bin/dhall-to-yaml /usr/local/bin/

COPY .github /.github

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
