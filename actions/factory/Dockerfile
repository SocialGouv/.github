FROM ghcr.io/socialgouv/docker/dhall:6.32.0@sha256:350d89b94014bf01e0bc7a80d7b8621919759eea049efd6ea19f0750fe481376 as dhall_image

FROM alpine:3.14

RUN apk add --update --no-cache \
  bash=~5

COPY --from=dhall_image /usr/local/bin/dhall /usr/local/bin/
COPY --from=dhall_image /usr/local/bin/dhall-to-yaml /usr/local/bin/

COPY .github /.github

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
