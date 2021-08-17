{ container-structure-test =
    ./steps/container-structure-test.dhall
      sha256:39e1bda1b6947c0e4035dd08e5b2a147de4b96f18ea251213db9edd7018dc098
, docker-meta =
    ./steps/docker-meta.dhall
      sha256:eb33151d23c230a302df1e1c3e885af23d5715558e8d9e7b215aa35eeac61f0e
, docker-buildx =
    ./steps/docker-buildx.dhall
      sha256:40cd835f0c5d748ac6ba97b2a420fbf6a2f33511565f7dcc3d3788f93db96a5b
, docker-login =
    ./steps/docker-login.dhall
      sha256:d7a4f745f47fff75dacf9e565191919e94c0ddf587a288b8d24e19ee507e63c7
, docker-build-push =
    ./steps/docker-build-push.dhall
      sha256:c534bd99f59bc5cf6bb82e882a31fff25d49f52df541495f2f90f85025781b32
}
