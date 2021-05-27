FROM ghcr.io/socialgouv/docker/dhall:6.16.0@sha256:90b99bfe3f794ed9bf4e307136cecb3c518e60181f288af43961b80d752f1ca1 as dhall_image

FROM alpine:3.13

RUN apk add --update --no-cache \
  bash=~5

COPY --from=dhall_image /usr/local/bin/dhall /usr/local/bin/
COPY --from=dhall_image /usr/local/bin/dhall-to-yaml /usr/local/bin/

COPY .github /.github

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
