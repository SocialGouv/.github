FROM dhallhaskell/dhall:1.40.2@sha256:17c61d3d3560e1f2a9a59baa0a6160ef155e69b49eb21523adc8b443719f8b9b as dhall_image

FROM alpine:3.15

RUN apk add --update --no-cache \
  bash=~5 \
  git=~2

COPY --from=dhall_image /bin/dhall /bin/

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
