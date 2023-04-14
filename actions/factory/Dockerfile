FROM ghcr.io/socialgouv/docker/dhall:7.5.0@sha256:b491424837ff57115462c30d4e3224831d7f46deac9169a87b4c9e05444747eb as dhall_image

FROM alpine:3.17

RUN apk add --update --no-cache \
  bash=~5

COPY --from=dhall_image /usr/local/bin/dhall /usr/local/bin/
COPY --from=dhall_image /usr/local/bin/dhall-to-yaml /usr/local/bin/

COPY .github /.github

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
