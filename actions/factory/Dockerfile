FROM ghcr.io/socialgouv/docker/dhall:6.47.7@sha256:a50dec6439d0e152c07d726017ce044e68eb7861770c18fe0d540f26deda95b8 as dhall_image

FROM alpine:3.14

RUN apk add --update --no-cache \
  bash=~5

COPY --from=dhall_image /usr/local/bin/dhall /usr/local/bin/
COPY --from=dhall_image /usr/local/bin/dhall-to-yaml /usr/local/bin/

COPY .github /.github

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
