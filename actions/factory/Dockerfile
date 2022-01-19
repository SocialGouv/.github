FROM ghcr.io/socialgouv/docker/dhall:6.70.0@sha256:7126585741cd73c454fa4ce450d377d85d60c8a4555686cb32741324be58c452 as dhall_image

FROM alpine:3.15

RUN apk add --update --no-cache \
  bash=~5

COPY --from=dhall_image /usr/local/bin/dhall /usr/local/bin/
COPY --from=dhall_image /usr/local/bin/dhall-to-yaml /usr/local/bin/

COPY .github /.github

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
