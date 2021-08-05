FROM ghcr.io/socialgouv/docker/dhall:6.38.5@sha256:97921be3956518cd6fecc6d2fbe493a37dce7a755315b2b23e8a924dc6a87f02 as dhall_image

FROM alpine:3.14

RUN apk add --update --no-cache \
  bash=~5

COPY --from=dhall_image /usr/local/bin/dhall /usr/local/bin/
COPY --from=dhall_image /usr/local/bin/dhall-to-yaml /usr/local/bin/

COPY .github /.github

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
