FROM dhallhaskell/dhall:1.40.0@sha256:4ae2c25b4a115f633ff5ca59fa585a2766618d67697d495b9e59eddea94cd023 as dhall_image

FROM alpine:3.14

RUN apk add --update --no-cache \
  bash=~5 \
  git=~2

COPY --from=dhall_image /bin/dhall /bin/

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
