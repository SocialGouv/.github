FROM ghcr.io/socialgouv/docker/dhall:6.18.1@sha256:06ef717af44318217d6b0b8f17b4a020e7dba7612223beb4589f68400e220eff as dhall_image

FROM alpine:3.13

RUN apk add --update --no-cache \
  bash=~5

COPY --from=dhall_image /usr/local/bin/dhall /usr/local/bin/
COPY --from=dhall_image /usr/local/bin/dhall-to-yaml /usr/local/bin/

COPY .github /.github

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
