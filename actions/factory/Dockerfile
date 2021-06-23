FROM ghcr.io/socialgouv/docker/dhall:6.26.0@sha256:7e8737a381ac26d56709eb8d6ab4969faa0af2e7e8d6541d61f55ad53303c391 as dhall_image

FROM alpine:3.14

RUN apk add --update --no-cache \
  bash=~5

COPY --from=dhall_image /usr/local/bin/dhall /usr/local/bin/
COPY --from=dhall_image /usr/local/bin/dhall-to-yaml /usr/local/bin/

COPY .github /.github

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
