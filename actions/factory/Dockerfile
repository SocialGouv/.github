FROM ghcr.io/socialgouv/docker/dhall:6.52.0@sha256:2787b81257cb99160924793bcc1bf9564ef258e2cb36c040dc4da4858dfa5b57 as dhall_image

FROM alpine:3.14

RUN apk add --update --no-cache \
  bash=~5

COPY --from=dhall_image /usr/local/bin/dhall /usr/local/bin/
COPY --from=dhall_image /usr/local/bin/dhall-to-yaml /usr/local/bin/

COPY .github /.github

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
