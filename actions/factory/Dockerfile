FROM ghcr.io/socialgouv/docker/dhall:6.20.0@sha256:5863f8d5070bd58fc51352fbfc29e876dc8dafd636f086298aab69cf700dc011 as dhall_image

FROM alpine:3.13

RUN apk add --update --no-cache \
  bash=~5

COPY --from=dhall_image /usr/local/bin/dhall /usr/local/bin/
COPY --from=dhall_image /usr/local/bin/dhall-to-yaml /usr/local/bin/

COPY .github /.github

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
