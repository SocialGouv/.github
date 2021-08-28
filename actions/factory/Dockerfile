FROM ghcr.io/socialgouv/docker/dhall:6.45.1@sha256:ab4ee9f606034949666fa8fceaf27c301f77edd07cbd8bf7598d8218e34885e9 as dhall_image

FROM alpine:3.14

RUN apk add --update --no-cache \
  bash=~5

COPY --from=dhall_image /usr/local/bin/dhall /usr/local/bin/
COPY --from=dhall_image /usr/local/bin/dhall-to-yaml /usr/local/bin/

COPY .github /.github

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
