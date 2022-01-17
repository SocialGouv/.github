FROM ghcr.io/socialgouv/docker/dhall:6.69.1@sha256:24e4d9e787eb9d371d517c6456c1cba2bdca68508516209f887d9769be47c5e7 as dhall_image

FROM alpine:3.15

RUN apk add --update --no-cache \
  bash=~5

COPY --from=dhall_image /usr/local/bin/dhall /usr/local/bin/
COPY --from=dhall_image /usr/local/bin/dhall-to-yaml /usr/local/bin/

COPY .github /.github

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
