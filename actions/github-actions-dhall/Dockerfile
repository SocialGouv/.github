FROM dhallhaskell/dhall:1.38.1@sha256:b2b3d90f44bf37e9e5b0e4f96c3e260dbc3cc9acf6271a02c27e7fa09e64d941 as dhall_image

FROM alpine:3.13

RUN apk add --update --no-cache \
  bash=~5 \
  git=~2

COPY --from=dhall_image /bin/dhall /bin/

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
