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
      sha256:d7a4f745f47fff75dacf9e565191919e94c0ddf587a288b8d24e19ee507e63c7
, docker-build-push =
    ./steps/docker-build-push.dhall
      sha256:8bd88aba9d1d6687737e6f1e38e14bf2d95be03ed1c94b21cf26b0ba18f81311
}
