FROM ghcr.io/socialgouv/docker/dhall:6.7.1@sha256:522321dd41fbbd057eaf14d35331d260cea2ab9d4312357ce1ad8b951423dd60 as dhall_image

FROM alpine:3.13

RUN apk add --update --no-cache \
  bash=~5

COPY --from=dhall_image /usr/local/bin/dhall /usr/local/bin/
COPY --from=dhall_image /usr/local/bin/dhall-to-yaml /usr/local/bin/

COPY .github /.github

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
