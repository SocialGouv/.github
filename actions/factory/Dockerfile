FROM ghcr.io/socialgouv/docker/dhall:6.47.6@sha256:2e2beacaab656d4ac19ce4266a37c031b561307eab3a688a1b205572e8301c96 as dhall_image

FROM alpine:3.14

RUN apk add --update --no-cache \
  bash=~5

COPY --from=dhall_image /usr/local/bin/dhall /usr/local/bin/
COPY --from=dhall_image /usr/local/bin/dhall-to-yaml /usr/local/bin/

COPY .github /.github

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
