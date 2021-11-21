FROM ghcr.io/socialgouv/docker/dhall:6.62.0@sha256:d0763a52f454f919f5c61ea64106ac856bdb988f7b64de800ee5f24839ae115d as dhall_image

FROM alpine:3.15

RUN apk add --update --no-cache \
  bash=~5

COPY --from=dhall_image /usr/local/bin/dhall /usr/local/bin/
COPY --from=dhall_image /usr/local/bin/dhall-to-yaml /usr/local/bin/

COPY .github /.github

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
