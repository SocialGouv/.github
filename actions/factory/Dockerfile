FROM ghcr.io/socialgouv/docker/dhall:6.12.0@sha256:93bb3e980ac46d8b60628395c62ab304db72a2ca909f22509773fc96025537be as dhall_image

FROM alpine:3.13

RUN apk add --update --no-cache \
  bash=~5

COPY --from=dhall_image /usr/local/bin/dhall /usr/local/bin/
COPY --from=dhall_image /usr/local/bin/dhall-to-yaml /usr/local/bin/

COPY .github /.github

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
