FROM ghcr.io/socialgouv/docker/dhall:6.53.2@sha256:f2fc32dd11caf3eadc2055717c5704611c343ad33ae401c771f6d6085c320b09 as dhall_image

FROM alpine:3.14

RUN apk add --update --no-cache \
  bash=~5

COPY --from=dhall_image /usr/local/bin/dhall /usr/local/bin/
COPY --from=dhall_image /usr/local/bin/dhall-to-yaml /usr/local/bin/

COPY .github /.github

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
