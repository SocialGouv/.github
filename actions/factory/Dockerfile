FROM ghcr.io/socialgouv/docker/dhall:6.45.0@sha256:e878d0adf28bbbf620fab111af24f1f1c5fc26fbd87463def4798105ffc8e2ee as dhall_image

FROM alpine:3.14

RUN apk add --update --no-cache \
  bash=~5

COPY --from=dhall_image /usr/local/bin/dhall /usr/local/bin/
COPY --from=dhall_image /usr/local/bin/dhall-to-yaml /usr/local/bin/

COPY .github /.github

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
