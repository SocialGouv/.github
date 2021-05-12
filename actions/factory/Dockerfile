FROM ghcr.io/socialgouv/docker/dhall:6.8.1@sha256:7a1c386c74d5da3f4a5c2fb6978249578ff9652dc4534bcf8906c87afe1e0efe as dhall_image

FROM alpine:3.13

RUN apk add --update --no-cache \
  bash=~5

COPY --from=dhall_image /usr/local/bin/dhall /usr/local/bin/
COPY --from=dhall_image /usr/local/bin/dhall-to-yaml /usr/local/bin/

COPY .github /.github

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
