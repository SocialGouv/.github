FROM dhallhaskell/dhall:1.39.0@sha256:c7ce65074e602a595b8211d9a731e946c32682758a7fac6abe82a08f4e5a2719 as dhall_image

FROM alpine:3.14

RUN apk add --update --no-cache \
  bash=~5 \
  git=~2

COPY --from=dhall_image /bin/dhall /bin/

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
