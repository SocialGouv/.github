FROM dhallhaskell/dhall:1.41.2@sha256:5cf87a7b55910b0e76e38979b1371bc5dedfffd36d57979edae940c2fe57ac11 as dhall_image

FROM alpine:3.17

RUN apk add --update --no-cache \
  bash=~5 \
  git=~2

COPY --from=dhall_image /bin/dhall /bin/

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
