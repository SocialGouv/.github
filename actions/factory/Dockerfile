FROM ghcr.io/socialgouv/docker/dhall:6.10.0@sha256:c98709ac8217eba611b3152ecf483ae7e0913e4556394372a2ee0a0e66a51c37 as dhall_image

FROM alpine:3.13

RUN apk add --update --no-cache \
  bash=~5

COPY --from=dhall_image /usr/local/bin/dhall /usr/local/bin/
COPY --from=dhall_image /usr/local/bin/dhall-to-yaml /usr/local/bin/

COPY .github /.github

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
