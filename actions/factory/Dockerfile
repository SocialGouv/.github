FROM ghcr.io/socialgouv/docker/dhall:6.44.0@sha256:60d0e3c0560ba2c7d7c432742566a644fe54c6b8b10076e074fed4211df73173 as dhall_image

FROM alpine:3.14

RUN apk add --update --no-cache \
  bash=~5

COPY --from=dhall_image /usr/local/bin/dhall /usr/local/bin/
COPY --from=dhall_image /usr/local/bin/dhall-to-yaml /usr/local/bin/

COPY .github /.github

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
