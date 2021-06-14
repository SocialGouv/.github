FROM ghcr.io/socialgouv/docker/dhall:6.21.1@sha256:5f4ad889213ec46bc0411d6fcfa3eabe5df80bd5607cb1d9427f1256feb4cb2d as dhall_image

FROM alpine:3.13

RUN apk add --update --no-cache \
  bash=~5

COPY --from=dhall_image /usr/local/bin/dhall /usr/local/bin/
COPY --from=dhall_image /usr/local/bin/dhall-to-yaml /usr/local/bin/

COPY .github /.github

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
