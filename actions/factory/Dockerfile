FROM ghcr.io/socialgouv/docker/dhall:7.5.1@sha256:722e1c4ebcb536c0d094ca1b021d6f087f96d0f679c60a690b3efff1d63daaa6 as dhall_image

FROM alpine:3.17

RUN apk add --update --no-cache \
  bash=~5

COPY --from=dhall_image /usr/local/bin/dhall /usr/local/bin/
COPY --from=dhall_image /usr/local/bin/dhall-to-yaml /usr/local/bin/

COPY .github /.github

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
