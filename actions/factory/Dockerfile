FROM ghcr.io/socialgouv/docker/dhall:6.39.0@sha256:dd66d5f1b57452516d89cbebc1c85452cd92563474397184b63b0bcde972d286 as dhall_image

FROM alpine:3.14

RUN apk add --update --no-cache \
  bash=~5

COPY --from=dhall_image /usr/local/bin/dhall /usr/local/bin/
COPY --from=dhall_image /usr/local/bin/dhall-to-yaml /usr/local/bin/

COPY .github /.github

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
