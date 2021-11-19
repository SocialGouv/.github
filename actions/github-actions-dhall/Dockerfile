FROM dhallhaskell/dhall:1.40.1@sha256:b1296a2cbdccb4d5c91fbab0b524550c861a252709cda79dd9b16c2758b416c0 as dhall_image

FROM alpine:3.15

RUN apk add --update --no-cache \
  bash=~5 \
  git=~2

COPY --from=dhall_image /bin/dhall /bin/

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
