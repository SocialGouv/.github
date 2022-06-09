FROM ghcr.io/socialgouv/docker/dhall:7.0.1@sha256:8d7ac50a32432824b9d70901830b500b2dc41d91de424e46217fd2f632eb659b as dhall_image

FROM alpine:3.16

RUN apk add --update --no-cache \
  bash=~5

COPY --from=dhall_image /usr/local/bin/dhall /usr/local/bin/
COPY --from=dhall_image /usr/local/bin/dhall-to-yaml /usr/local/bin/

COPY .github /.github

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
