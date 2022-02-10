FROM ghcr.io/socialgouv/docker/dhall:6.70.1@sha256:74f5ece4f5b6eaf6bb10bf08620f4595aadfa53668ef6b11861d191c24362f26 as dhall_image

FROM alpine:3.15

RUN apk add --update --no-cache \
  bash=~5

COPY --from=dhall_image /usr/local/bin/dhall /usr/local/bin/
COPY --from=dhall_image /usr/local/bin/dhall-to-yaml /usr/local/bin/

COPY .github /.github

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
