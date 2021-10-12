FROM ghcr.io/socialgouv/docker/dhall:6.56.1@sha256:72ef2fe34b1a0890b8466b0eb427c640c5005e04b8e64c9d218c650eb18a6a11 as dhall_image

FROM alpine:3.14

RUN apk add --update --no-cache \
  bash=~5

COPY --from=dhall_image /usr/local/bin/dhall /usr/local/bin/
COPY --from=dhall_image /usr/local/bin/dhall-to-yaml /usr/local/bin/

COPY .github /.github

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
