FROM ghcr.io/socialgouv/docker/dhall:6.47.2@sha256:a3d472ab93a718bca3e72ba4a823ab227f8fa6eefdd929776817b0f2d0310277 as dhall_image

FROM alpine:3.14

RUN apk add --update --no-cache \
  bash=~5

COPY --from=dhall_image /usr/local/bin/dhall /usr/local/bin/
COPY --from=dhall_image /usr/local/bin/dhall-to-yaml /usr/local/bin/

COPY .github /.github

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
