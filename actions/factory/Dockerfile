FROM ghcr.io/socialgouv/docker/dhall:7.6.1@sha256:56d9f660dea91d4794bf8c29810414160ed9d7811591322041d93ffa58c788b9 as dhall_image

FROM alpine:3.22

RUN apk add --update --no-cache \
  bash=~5

COPY --from=dhall_image /usr/local/bin/dhall /usr/local/bin/
COPY --from=dhall_image /usr/local/bin/dhall-to-yaml /usr/local/bin/

COPY .github /.github

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
