FROM ghcr.io/socialgouv/docker/dhall:6.64.1@sha256:d5634d73a450ef569a79028463e79c98f1241509b80aee2afeff4a0f1abdcafc as dhall_image

FROM alpine:3.15

RUN apk add --update --no-cache \
  bash=~5

COPY --from=dhall_image /usr/local/bin/dhall /usr/local/bin/
COPY --from=dhall_image /usr/local/bin/dhall-to-yaml /usr/local/bin/

COPY .github /.github

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
