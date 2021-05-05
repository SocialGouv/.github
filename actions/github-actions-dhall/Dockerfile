FROM dhallhaskell/dhall:1.38.0@sha256:07d95d249cb88df8cf63c1a42d31abdc155289cc30d09fdd0db89f5a34a680a8 as dhall_image

FROM alpine:3.13

RUN apk add --update --no-cache \
  bash=~5 \
  git=~2

COPY --from=dhall_image /bin/dhall /bin/

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
