FROM dhallhaskell/dhall:1.42.1@sha256:7594b8b8119c4ead4b09eace76bae830be448a4acfbf9a36fabdeca62fb17191 as dhall_image

FROM alpine:3.20

RUN apk add --update --no-cache \
  bash=~5 \
  git=~2

COPY --from=dhall_image /bin/dhall /bin/

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
