FROM ghcr.io/socialgouv/docker/dhall:6.4.0@sha256:809ebdf8f3f67d241cdc8d775e540022acb8ce3b26de44bdddad2cdac5f415b1 as dhall_image

FROM alpine:3.13

RUN apk add --update --no-cache \
  bash=~5

COPY --from=dhall_image /usr/local/bin/dhall /usr/local/bin/
COPY --from=dhall_image /usr/local/bin/dhall-to-yaml /usr/local/bin/

COPY .github /.github

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
