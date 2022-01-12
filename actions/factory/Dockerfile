FROM ghcr.io/socialgouv/docker/dhall:6.68.0@sha256:657e499b7519a7d25d9c9c02597710e82ddadab1094686fa9e5690ec868cd039 as dhall_image

FROM alpine:3.15

RUN apk add --update --no-cache \
  bash=~5

COPY --from=dhall_image /usr/local/bin/dhall /usr/local/bin/
COPY --from=dhall_image /usr/local/bin/dhall-to-yaml /usr/local/bin/

COPY .github /.github

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
