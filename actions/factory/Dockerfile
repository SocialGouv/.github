FROM ghcr.io/socialgouv/docker/dhall:6.18.0@sha256:f53b136b289e780aa34ad46c57ca7c249eef58f7df65ede5ff297f8dd2dcfc09 as dhall_image

FROM alpine:3.13

RUN apk add --update --no-cache \
  bash=~5

COPY --from=dhall_image /usr/local/bin/dhall /usr/local/bin/
COPY --from=dhall_image /usr/local/bin/dhall-to-yaml /usr/local/bin/

COPY .github /.github

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
