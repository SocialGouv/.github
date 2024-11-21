{ container-structure-test =
    ./steps/container-structure-test.dhall
      sha256:04e25f9cb1840d99b4d3dcdbf55970934a5e570d9b894ee454f9deca56ccd2a2
, docker-meta =
    ./steps/docker-meta.dhall
      sha256:01ac552e2586990f46ff46e1452e8b326b79b3b91303138e03416a289ac69d64
, docker-buildx =
    ./steps/docker-buildx.dhall
      sha256:8eb9033a64676d10eba60d5ba270bae17f4ff3d2471c9294758be3ce76ec07b0
, docker-login =
    ./steps/docker-login.dhall
      sha256:1c3ed0a5ba40e089323cbb1fd3f3d9313bc63f2f8b7dcbf35d01a96daa46cbf5
, docker-build-push =
    ./steps/docker-build-push.dhall
      sha256:8bd88aba9d1d6687737e6f1e38e14bf2d95be03ed1c94b21cf26b0ba18f81311
}
