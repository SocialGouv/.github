FROM ghcr.io/socialgouv/docker/dhall:6.32.3@sha256:a928a61263ec489049d5a2b7d7171b5be72c98a7fbd7495852bac0489fd1bf98 as dhall_image

FROM alpine:3.14

RUN apk add --update --no-cache \
  bash=~5

COPY --from=dhall_image /usr/local/bin/dhall /usr/local/bin/
COPY --from=dhall_image /usr/local/bin/dhall-to-yaml /usr/local/bin/

COPY .github /.github

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
