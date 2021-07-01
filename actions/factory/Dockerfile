FROM ghcr.io/socialgouv/docker/dhall:6.26.3@sha256:a25c3aa510c7e8001f426b14dcb5076aaba448fca0bd58bf23ff2b1a10d1cee6 as dhall_image

FROM alpine:3.14

RUN apk add --update --no-cache \
  bash=~5

COPY --from=dhall_image /usr/local/bin/dhall /usr/local/bin/
COPY --from=dhall_image /usr/local/bin/dhall-to-yaml /usr/local/bin/

COPY .github /.github

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
