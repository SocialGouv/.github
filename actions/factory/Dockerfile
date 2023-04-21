FROM ghcr.io/socialgouv/docker/dhall:7.6.0@sha256:4121bba96352766ddfb596c5e8a761d3ee5528697fd47d832a2db6558de92bb2 as dhall_image

FROM alpine:3.17

RUN apk add --update --no-cache \
  bash=~5

COPY --from=dhall_image /usr/local/bin/dhall /usr/local/bin/
COPY --from=dhall_image /usr/local/bin/dhall-to-yaml /usr/local/bin/

COPY .github /.github

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
