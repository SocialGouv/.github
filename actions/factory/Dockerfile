FROM ghcr.io/socialgouv/docker/dhall:6.0.1@sha256:41eb442001e6d9449ae45898d98014958b5f3f481fd94291bc06ee9e649cf5b7 as dhall_image

FROM alpine:3.13

RUN apk add --update --no-cache \
  bash=~5

COPY --from=dhall_image /usr/local/bin/dhall /usr/local/bin/
COPY --from=dhall_image /usr/local/bin/dhall-to-yaml /usr/local/bin/

COPY workflows /workflows

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
