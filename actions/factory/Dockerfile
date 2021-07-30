FROM ghcr.io/socialgouv/docker/dhall:6.38.3@sha256:628d302597c05beda4ebb10bacaf0f23cb819c27a105e137a880588085706d0a as dhall_image

FROM alpine:3.14

RUN apk add --update --no-cache \
  bash=~5

COPY --from=dhall_image /usr/local/bin/dhall /usr/local/bin/
COPY --from=dhall_image /usr/local/bin/dhall-to-yaml /usr/local/bin/

COPY .github /.github

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
