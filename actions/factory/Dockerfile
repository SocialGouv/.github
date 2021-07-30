FROM ghcr.io/socialgouv/docker/dhall:6.38.4@sha256:a85251be6bccf804e9ce5ae3b41495093ab71c7341fe183eca9d403846501c84 as dhall_image

FROM alpine:3.14

RUN apk add --update --no-cache \
  bash=~5

COPY --from=dhall_image /usr/local/bin/dhall /usr/local/bin/
COPY --from=dhall_image /usr/local/bin/dhall-to-yaml /usr/local/bin/

COPY .github /.github

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
