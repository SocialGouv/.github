FROM ghcr.io/socialgouv/docker/dhall:6.31.1@sha256:2d67de2d154ead8d27fea5822b7572bad302670da6b6b1b006022cea30151b74 as dhall_image

FROM alpine:3.14

RUN apk add --update --no-cache \
  bash=~5

COPY --from=dhall_image /usr/local/bin/dhall /usr/local/bin/
COPY --from=dhall_image /usr/local/bin/dhall-to-yaml /usr/local/bin/

COPY .github /.github

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
