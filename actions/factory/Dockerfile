FROM ghcr.io/socialgouv/docker/dhall:6.34.0@sha256:781e324134e80fd80dc34b79a878f246f3072c8bc4ceb260d6a777e548bdd454 as dhall_image

FROM alpine:3.14

RUN apk add --update --no-cache \
  bash=~5

COPY --from=dhall_image /usr/local/bin/dhall /usr/local/bin/
COPY --from=dhall_image /usr/local/bin/dhall-to-yaml /usr/local/bin/

COPY .github /.github

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
