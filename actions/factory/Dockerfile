FROM ghcr.io/socialgouv/docker/dhall:6.48.1@sha256:3e4bdbfb5ea31daed778aef95222a210c804668d4210cee73d0bb551667bbfef as dhall_image

FROM alpine:3.14

RUN apk add --update --no-cache \
  bash=~5

COPY --from=dhall_image /usr/local/bin/dhall /usr/local/bin/
COPY --from=dhall_image /usr/local/bin/dhall-to-yaml /usr/local/bin/

COPY .github /.github

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
