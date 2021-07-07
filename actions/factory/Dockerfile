FROM ghcr.io/socialgouv/docker/dhall:6.26.4@sha256:5f028b7a8e739b00ee4a6c1bff335e6d20f30b8e211f0014310f7243803fb109 as dhall_image

FROM alpine:3.14

RUN apk add --update --no-cache \
  bash=~5

COPY --from=dhall_image /usr/local/bin/dhall /usr/local/bin/
COPY --from=dhall_image /usr/local/bin/dhall-to-yaml /usr/local/bin/

COPY .github /.github

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
