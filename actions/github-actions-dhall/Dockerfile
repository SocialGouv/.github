FROM dhallhaskell/dhall:1.41.1@sha256:45cc2b3fc00f11be3055541d84b3764d9d68a9ebc75436229ad23ceeaee419d2 as dhall_image

FROM alpine:3.16

RUN apk add --update --no-cache \
  bash=~5 \
  git=~2

COPY --from=dhall_image /bin/dhall /bin/

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
