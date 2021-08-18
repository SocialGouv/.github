FROM ghcr.io/socialgouv/docker/dhall:6.43.0@sha256:5a6333a81a681e76cc7d5f548c01ef50da682f415dea80853d334d2deccf2cf9 as dhall_image

FROM alpine:3.14

RUN apk add --update --no-cache \
  bash=~5

COPY --from=dhall_image /usr/local/bin/dhall /usr/local/bin/
COPY --from=dhall_image /usr/local/bin/dhall-to-yaml /usr/local/bin/

COPY .github /.github

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
