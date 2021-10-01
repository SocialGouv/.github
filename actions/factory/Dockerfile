FROM ghcr.io/socialgouv/docker/dhall:6.53.1@sha256:7c648ba10d082a7e7fc5b50c56200ae1c7f970ad557200d16b3ddc255e604ac3 as dhall_image

FROM alpine:3.14

RUN apk add --update --no-cache \
  bash=~5

COPY --from=dhall_image /usr/local/bin/dhall /usr/local/bin/
COPY --from=dhall_image /usr/local/bin/dhall-to-yaml /usr/local/bin/

COPY .github /.github

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
