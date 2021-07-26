FROM ghcr.io/socialgouv/docker/dhall:6.36.0@sha256:1c738a6ef5f85e9029928b9884684ce4816a77387cb414cde5b6acfd4aae8616 as dhall_image

FROM alpine:3.14

RUN apk add --update --no-cache \
  bash=~5

COPY --from=dhall_image /usr/local/bin/dhall /usr/local/bin/
COPY --from=dhall_image /usr/local/bin/dhall-to-yaml /usr/local/bin/

COPY .github /.github

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
