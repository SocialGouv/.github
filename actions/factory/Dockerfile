FROM ghcr.io/socialgouv/docker/dhall:6.23.1@sha256:44294d43a5c8528255544b2937bc15f47bce7b2506db831b7ebf57db672726cc as dhall_image

FROM alpine:3.14

RUN apk add --update --no-cache \
  bash=~5

COPY --from=dhall_image /usr/local/bin/dhall /usr/local/bin/
COPY --from=dhall_image /usr/local/bin/dhall-to-yaml /usr/local/bin/

COPY .github /.github

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
