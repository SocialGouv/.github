FROM ghcr.io/socialgouv/docker/dhall:6.38.0@sha256:29936e30bdb24a5dc30b515b18c35dff718b29cc9cf4f3c23749c6bac4d13f2d as dhall_image

FROM alpine:3.14

RUN apk add --update --no-cache \
  bash=~5

COPY --from=dhall_image /usr/local/bin/dhall /usr/local/bin/
COPY --from=dhall_image /usr/local/bin/dhall-to-yaml /usr/local/bin/

COPY .github /.github

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
