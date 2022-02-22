FROM dhallhaskell/dhall:1.41.0@sha256:e2389cd1bde2c421ecf3b0cfc60f9679f3d9fe3823917f311549eaeccf61d7ea as dhall_image

FROM alpine:3.15

RUN apk add --update --no-cache \
  bash=~5 \
  git=~2

COPY --from=dhall_image /bin/dhall /bin/

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
