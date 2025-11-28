FROM dhallhaskell/dhall:1.42.2@sha256:100466b6fc3bdaf33fa9805af3685fa6179ff9d822bbb80c9252c4c6c5252d4b as dhall_image

FROM alpine:3.22

RUN apk add --update --no-cache \
  bash=~5 \
  git=~2

COPY --from=dhall_image /bin/dhall /bin/

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
