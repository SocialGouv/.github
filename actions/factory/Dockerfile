FROM ghcr.io/socialgouv/docker/dhall:6.67.0@sha256:8f5f25bf98da5d4f30cc7cdcf077f771a65a4c5a2df04521c2f3902d9e96b694 as dhall_image

FROM alpine:3.15

RUN apk add --update --no-cache \
  bash=~5

COPY --from=dhall_image /usr/local/bin/dhall /usr/local/bin/
COPY --from=dhall_image /usr/local/bin/dhall-to-yaml /usr/local/bin/

COPY .github /.github

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
