FROM ghcr.io/socialgouv/docker/dhall:6.26.6@sha256:b6d48b66528887501a5352a0c5a04c9e168dd67721f1384f120d1e0980754178 as dhall_image

FROM alpine:3.14

RUN apk add --update --no-cache \
  bash=~5

COPY --from=dhall_image /usr/local/bin/dhall /usr/local/bin/
COPY --from=dhall_image /usr/local/bin/dhall-to-yaml /usr/local/bin/

COPY .github /.github

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
