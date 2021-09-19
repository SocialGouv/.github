FROM ghcr.io/socialgouv/docker/dhall:6.50.1@sha256:374d74586c07af6b78e43ea0b63d12fcd55abafae7d9b47a9d1e3d103fd9bba3 as dhall_image

FROM alpine:3.14

RUN apk add --update --no-cache \
  bash=~5

COPY --from=dhall_image /usr/local/bin/dhall /usr/local/bin/
COPY --from=dhall_image /usr/local/bin/dhall-to-yaml /usr/local/bin/

COPY .github /.github

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
