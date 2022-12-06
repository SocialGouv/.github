FROM ghcr.io/socialgouv/docker/dhall:7.1.1@sha256:1db2491ab1906555b1277546ebfa315b556b351b88d1a71ba322fdc35074bd92 as dhall_image

FROM alpine:3.17

RUN apk add --update --no-cache \
  bash=~5

COPY --from=dhall_image /usr/local/bin/dhall /usr/local/bin/
COPY --from=dhall_image /usr/local/bin/dhall-to-yaml /usr/local/bin/

COPY .github /.github

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
