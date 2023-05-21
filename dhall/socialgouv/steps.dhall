{ container-structure-test =
    ./steps/container-structure-test.dhall
      sha256:4b643822963476c495ef148f12e6730a82a3d7a3492b7ac2b7bb90632b8340bb
, docker-meta =
    ./steps/docker-meta.dhall
      sha256:9361c9fc2c0217332f4c36da856db6976d0ebd22b8ab343d6a2e7e802acb6c6c
, docker-buildx =
    ./steps/docker-buildx.dhall
      sha256:07af81a622a27f314b63f8017d2df6dada3dce9645007ef11b75b72a995f7153
, docker-login =
    ./steps/docker-login.dhall
      sha256:101ecfae7c7f45e1c760f1fd5c1aac9d94691f5cf15645cd5ac922dfa06e1d54
, docker-build-push =
    ./steps/docker-build-push.dhall
      sha256:d6389f9de917e0711b05cc2c3d8d2ccfcc9d570654c1e89e0fa5148ffe92e9e6
}
