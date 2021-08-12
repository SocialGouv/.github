FROM ghcr.io/socialgouv/docker/dhall:6.39.1@sha256:99b04407e642e3047b55056a5a7e1afb2ee3bf950a09d5d6847709b570b3b46f as dhall_image

FROM alpine:3.14

RUN apk add --update --no-cache \
  bash=~5

COPY --from=dhall_image /usr/local/bin/dhall /usr/local/bin/
COPY --from=dhall_image /usr/local/bin/dhall-to-yaml /usr/local/bin/

COPY .github /.github

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
