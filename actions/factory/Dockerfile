FROM ghcr.io/socialgouv/docker/dhall:6.64.0@sha256:da15fad17ad156ce99b438f91089f6b8fcce668dce9820fb14535b66a7784de9 as dhall_image

FROM alpine:3.15

RUN apk add --update --no-cache \
  bash=~5

COPY --from=dhall_image /usr/local/bin/dhall /usr/local/bin/
COPY --from=dhall_image /usr/local/bin/dhall-to-yaml /usr/local/bin/

COPY .github /.github

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
