FROM ghcr.io/socialgouv/docker/dhall:6.56.0@sha256:38e27daf7d844339eeec79e59131ea4c636068aa7ac037f934a6a3b40f63e382 as dhall_image

FROM alpine:3.14

RUN apk add --update --no-cache \
  bash=~5

COPY --from=dhall_image /usr/local/bin/dhall /usr/local/bin/
COPY --from=dhall_image /usr/local/bin/dhall-to-yaml /usr/local/bin/

COPY .github /.github

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
