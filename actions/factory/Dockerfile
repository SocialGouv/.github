FROM ghcr.io/socialgouv/docker/dhall:6.25.0@sha256:a8cfa3afe8fb49b667b4fd31fdbeccba08a7c273ba8ad0694f0000b4cb66a904 as dhall_image

FROM alpine:3.14

RUN apk add --update --no-cache \
  bash=~5

COPY --from=dhall_image /usr/local/bin/dhall /usr/local/bin/
COPY --from=dhall_image /usr/local/bin/dhall-to-yaml /usr/local/bin/

COPY .github /.github

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
