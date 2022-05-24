FROM ghcr.io/socialgouv/docker/dhall:7.0.0@sha256:34ac10373a761a6a74e5268ac61499d4b2dc1f4041b1a6349614f2651ca9e620 as dhall_image

FROM alpine:3.16

RUN apk add --update --no-cache \
  bash=~5

COPY --from=dhall_image /usr/local/bin/dhall /usr/local/bin/
COPY --from=dhall_image /usr/local/bin/dhall-to-yaml /usr/local/bin/

COPY .github /.github

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
