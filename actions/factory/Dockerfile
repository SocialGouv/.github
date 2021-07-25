FROM ghcr.io/socialgouv/docker/dhall:6.35.0@sha256:9ff37ed42f30de7bdbc2f003839bce210d03771f4e72276fb2cc9a45feb3331b as dhall_image

FROM alpine:3.14

RUN apk add --update --no-cache \
  bash=~5

COPY --from=dhall_image /usr/local/bin/dhall /usr/local/bin/
COPY --from=dhall_image /usr/local/bin/dhall-to-yaml /usr/local/bin/

COPY .github /.github

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
