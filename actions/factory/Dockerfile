FROM ghcr.io/socialgouv/docker/dhall:6.32.1@sha256:5d45d832de70da02464e237a0e919c608554eecdab8fa5fe384c2d05eacc85c7 as dhall_image

FROM alpine:3.14

RUN apk add --update --no-cache \
  bash=~5

COPY --from=dhall_image /usr/local/bin/dhall /usr/local/bin/
COPY --from=dhall_image /usr/local/bin/dhall-to-yaml /usr/local/bin/

COPY .github /.github

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
