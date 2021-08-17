{ container-structure-test =
    ./steps/container-structure-test.dhall
      sha256:04e25f9cb1840d99b4d3dcdbf55970934a5e570d9b894ee454f9deca56ccd2a2
, docker-meta =
    ./steps/docker-meta.dhall
      sha256:c324fae0f39bc59c40d3eb857be04101ff200b6c82207c7fa4f941df37084ada
, docker-buildx =
    ./steps/docker-buildx.dhall
      sha256:40cd835f0c5d748ac6ba97b2a420fbf6a2f33511565f7dcc3d3788f93db96a5b
, docker-login =
    ./steps/docker-login.dhall
      sha256:d98eae1a328d55f1faa911c1bc7990b84fd5c6f85735116192470e047b29a1d8
, docker-build-push =
    ./steps/docker-build-push.dhall
      sha256:c534bd99f59bc5cf6bb82e882a31fff25d49f52df541495f2f90f85025781b32
}
