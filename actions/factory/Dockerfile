FROM ghcr.io/socialgouv/docker/dhall:6.26.2@sha256:5a08053cf4b11bc4874734b82229552d28a5f0937c0af77058493d9bd99a88de as dhall_image

FROM alpine:3.14

RUN apk add --update --no-cache \
  bash=~5

COPY --from=dhall_image /usr/local/bin/dhall /usr/local/bin/
COPY --from=dhall_image /usr/local/bin/dhall-to-yaml /usr/local/bin/

COPY .github /.github

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
