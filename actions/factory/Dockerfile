FROM ghcr.io/socialgouv/docker/dhall:6.58.2@sha256:28c4bd400296e7b573a340cc9a0bc23029acd6a6a12b8f3fc47e42316cc473b3 as dhall_image

FROM alpine:3.14

RUN apk add --update --no-cache \
  bash=~5

COPY --from=dhall_image /usr/local/bin/dhall /usr/local/bin/
COPY --from=dhall_image /usr/local/bin/dhall-to-yaml /usr/local/bin/

COPY .github /.github

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
