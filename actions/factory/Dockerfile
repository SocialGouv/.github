FROM ghcr.io/socialgouv/docker/dhall:6.48.0@sha256:59fbeb5a53361b1d3b42049cef3af47b16459771389b3293e1d3efe7be55a16f as dhall_image

FROM alpine:3.14

RUN apk add --update --no-cache \
  bash=~5

COPY --from=dhall_image /usr/local/bin/dhall /usr/local/bin/
COPY --from=dhall_image /usr/local/bin/dhall-to-yaml /usr/local/bin/

COPY .github /.github

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
