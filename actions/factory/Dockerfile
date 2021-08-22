FROM ghcr.io/socialgouv/docker/dhall:6.43.2@sha256:875d52aa1195df1b861d197009796e47ea891c09ef2a1ec4a3e36a6292894673 as dhall_image

FROM alpine:3.14

RUN apk add --update --no-cache \
  bash=~5

COPY --from=dhall_image /usr/local/bin/dhall /usr/local/bin/
COPY --from=dhall_image /usr/local/bin/dhall-to-yaml /usr/local/bin/

COPY .github /.github

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
