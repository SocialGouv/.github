FROM ghcr.io/socialgouv/docker/dhall:6.4.1@sha256:5b32387c90ce8fff848d9b3f436346ba24b7278966ee8fbb97f6f09da68cf9a4 as dhall_image

FROM alpine:3.13

RUN apk add --update --no-cache \
  bash=~5

COPY --from=dhall_image /usr/local/bin/dhall /usr/local/bin/
COPY --from=dhall_image /usr/local/bin/dhall-to-yaml /usr/local/bin/

COPY .github /.github

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
