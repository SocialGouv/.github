FROM ghcr.io/socialgouv/docker/dhall:6.55.0@sha256:e7c7c5a016fbc6a843069de07818e659f307eda14d278b0eb2c00a2783deb719 as dhall_image

FROM alpine:3.14

RUN apk add --update --no-cache \
  bash=~5

COPY --from=dhall_image /usr/local/bin/dhall /usr/local/bin/
COPY --from=dhall_image /usr/local/bin/dhall-to-yaml /usr/local/bin/

COPY .github /.github

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
