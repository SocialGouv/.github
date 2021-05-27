FROM ghcr.io/socialgouv/docker/dhall:6.15.1@sha256:36cb29308b4d67e7d6b99404fb2599e0e902e5e3d7a00dee7bc5d418d0d64884 as dhall_image

FROM alpine:3.13

RUN apk add --update --no-cache \
  bash=~5

COPY --from=dhall_image /usr/local/bin/dhall /usr/local/bin/
COPY --from=dhall_image /usr/local/bin/dhall-to-yaml /usr/local/bin/

COPY .github /.github

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
