FROM ghcr.io/socialgouv/docker/dhall:6.17.0@sha256:e7f26dac506e2d7e42a7928fd715fc06a5a717da5327f60ddc63b6c911634ae3 as dhall_image

FROM alpine:3.13

RUN apk add --update --no-cache \
  bash=~5

COPY --from=dhall_image /usr/local/bin/dhall /usr/local/bin/
COPY --from=dhall_image /usr/local/bin/dhall-to-yaml /usr/local/bin/

COPY .github /.github

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
