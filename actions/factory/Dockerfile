FROM ghcr.io/socialgouv/docker/dhall:6.57.0@sha256:79f9305086415ffa158c679b69ffd5befa4085d735f3c8e923203bf827e9a218 as dhall_image

FROM alpine:3.14

RUN apk add --update --no-cache \
  bash=~5

COPY --from=dhall_image /usr/local/bin/dhall /usr/local/bin/
COPY --from=dhall_image /usr/local/bin/dhall-to-yaml /usr/local/bin/

COPY .github /.github

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
