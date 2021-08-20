FROM ghcr.io/socialgouv/docker/dhall:6.43.1@sha256:ba556f1f36df0aa9b616cac97c3cd2e0ce4254afb3daa37050d9629ebf2cba56 as dhall_image

FROM alpine:3.14

RUN apk add --update --no-cache \
  bash=~5

COPY --from=dhall_image /usr/local/bin/dhall /usr/local/bin/
COPY --from=dhall_image /usr/local/bin/dhall-to-yaml /usr/local/bin/

COPY .github /.github

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
