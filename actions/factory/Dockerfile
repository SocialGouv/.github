FROM ghcr.io/socialgouv/docker/dhall:6.14.0@sha256:148ddcf129d71cd65639b71f91da147fcadbd3474daaef21f2fbe2458baad85a as dhall_image

FROM alpine:3.13

RUN apk add --update --no-cache \
  bash=~5

COPY --from=dhall_image /usr/local/bin/dhall /usr/local/bin/
COPY --from=dhall_image /usr/local/bin/dhall-to-yaml /usr/local/bin/

COPY .github /.github

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
