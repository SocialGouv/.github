FROM ghcr.io/socialgouv/docker/dhall:6.38.1@sha256:cba9fa6c72f6ea78ff9e863e4ff1eeac1430bc3d5ddcf062a6262fbb104f0d45 as dhall_image

FROM alpine:3.14

RUN apk add --update --no-cache \
  bash=~5

COPY --from=dhall_image /usr/local/bin/dhall /usr/local/bin/
COPY --from=dhall_image /usr/local/bin/dhall-to-yaml /usr/local/bin/

COPY .github /.github

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
