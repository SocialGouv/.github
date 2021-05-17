FROM ghcr.io/socialgouv/docker/dhall:6.10.1@sha256:c2a3c4109b6a2964f1ce1b2f2dd98f073721a5aab6f4bd640686f2c49f79daaa as dhall_image

FROM alpine:3.13

RUN apk add --update --no-cache \
  bash=~5

COPY --from=dhall_image /usr/local/bin/dhall /usr/local/bin/
COPY --from=dhall_image /usr/local/bin/dhall-to-yaml /usr/local/bin/

COPY .github /.github

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
