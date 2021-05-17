FROM ghcr.io/socialgouv/docker/dhall:6.11.0@sha256:2025f8df4bd3a274068f5200c4b3726a3a6571b7acd1b364050d3edf7aa6be96 as dhall_image

FROM alpine:3.13

RUN apk add --update --no-cache \
  bash=~5

COPY --from=dhall_image /usr/local/bin/dhall /usr/local/bin/
COPY --from=dhall_image /usr/local/bin/dhall-to-yaml /usr/local/bin/

COPY .github /.github

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
