FROM ghcr.io/socialgouv/docker/dhall:6.66.0@sha256:07284a2222fc211214c8269747262879fd6e9f47903f7137dc65c6bedc45eea3 as dhall_image

FROM alpine:3.15

RUN apk add --update --no-cache \
  bash=~5

COPY --from=dhall_image /usr/local/bin/dhall /usr/local/bin/
COPY --from=dhall_image /usr/local/bin/dhall-to-yaml /usr/local/bin/

COPY .github /.github

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
