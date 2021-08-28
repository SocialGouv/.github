FROM ghcr.io/socialgouv/docker/dhall:6.46.0@sha256:a175d4d86ad5a6dece87713d199dc2587115ccff5309b3449395c0dd74e99d87 as dhall_image

FROM alpine:3.14

RUN apk add --update --no-cache \
  bash=~5

COPY --from=dhall_image /usr/local/bin/dhall /usr/local/bin/
COPY --from=dhall_image /usr/local/bin/dhall-to-yaml /usr/local/bin/

COPY .github /.github

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
