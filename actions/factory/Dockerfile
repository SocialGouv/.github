FROM ghcr.io/socialgouv/docker/dhall:6.7.0@sha256:650dd69ffa49fdfe91046300c2c779506a48e5206d6e9fb66aea7ed8a68db712 as dhall_image

FROM alpine:3.13

RUN apk add --update --no-cache \
  bash=~5

COPY --from=dhall_image /usr/local/bin/dhall /usr/local/bin/
COPY --from=dhall_image /usr/local/bin/dhall-to-yaml /usr/local/bin/

COPY .github /.github

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
