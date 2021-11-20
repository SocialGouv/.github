FROM ghcr.io/socialgouv/docker/dhall:6.61.1@sha256:520d1cca8c9093d9a5e9c7b54d93c00433eae0dd85818c30561c7e807d393869 as dhall_image

FROM alpine:3.15

RUN apk add --update --no-cache \
  bash=~5

COPY --from=dhall_image /usr/local/bin/dhall /usr/local/bin/
COPY --from=dhall_image /usr/local/bin/dhall-to-yaml /usr/local/bin/

COPY .github /.github

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
