{ container-structure-test =
    ./steps/container-structure-test.dhall
      sha256:04e25f9cb1840d99b4d3dcdbf55970934a5e570d9b894ee454f9deca56ccd2a2
, docker-meta =
    ./steps/docker-meta.dhall
      sha256:c324fae0f39bc59c40d3eb857be04101ff200b6c82207c7fa4f941df37084ada
, docker-buildx =
    ./steps/docker-buildx.dhall
      sha256:8eb9033a64676d10eba60d5ba270bae17f4ff3d2471c9294758be3ce76ec07b0
, docker-login =
    ./steps/docker-login.dhall
      sha256:d98eae1a328d55f1faa911c1bc7990b84fd5c6f85735116192470e047b29a1d8
, docker-build-push =
    ./steps/docker-build-push.dhall
      sha256:8bd88aba9d1d6687737e6f1e38e14bf2d95be03ed1c94b21cf26b0ba18f81311
}
