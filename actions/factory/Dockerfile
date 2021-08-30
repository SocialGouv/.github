FROM ghcr.io/socialgouv/docker/dhall:6.47.1@sha256:0b10a3b37468999e08c175bb6d8bdc0cafc422ed2de34156e85204451b4b8d88 as dhall_image

FROM alpine:3.14

RUN apk add --update --no-cache \
  bash=~5

COPY --from=dhall_image /usr/local/bin/dhall /usr/local/bin/
COPY --from=dhall_image /usr/local/bin/dhall-to-yaml /usr/local/bin/

COPY .github /.github

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
