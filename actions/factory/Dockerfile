FROM ghcr.io/socialgouv/docker/dhall:6.38.6@sha256:4ca72d01cc7eb2004735a1a78f7851611523d94fbf5a9482ad123e8c3d1caa8e as dhall_image

FROM alpine:3.14

RUN apk add --update --no-cache \
  bash=~5

COPY --from=dhall_image /usr/local/bin/dhall /usr/local/bin/
COPY --from=dhall_image /usr/local/bin/dhall-to-yaml /usr/local/bin/

COPY .github /.github

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
