FROM ghcr.io/socialgouv/docker/dhall:6.47.5@sha256:14a44d8e2be47bcab2f6a353cee20546b30adc981a5ad3affe471cef369f36f6 as dhall_image

FROM alpine:3.14

RUN apk add --update --no-cache \
  bash=~5

COPY --from=dhall_image /usr/local/bin/dhall /usr/local/bin/
COPY --from=dhall_image /usr/local/bin/dhall-to-yaml /usr/local/bin/

COPY .github /.github

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
