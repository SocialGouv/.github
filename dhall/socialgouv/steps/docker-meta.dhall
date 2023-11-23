let GithubActions =
      ../../github-actions/package.dhall
        sha256:689f05f7e4f9e6355b8ce935ca0568b1a1fdbbd746e0bc4e2e5d8f238cfa4358

let ghaction-docker-meta =
      ../../steps/crazy-max/ghaction-docker-meta/package.dhall
        sha256:27856447b9a3399788f146b0aadb7475b64cffacd6cdeb6499baf21f989a9c53

let socialgouv/docker-meta =
      λ(args : { image_name : Text }) →
        ghaction-docker-meta.v3
          ghaction-docker-meta.Input::{
          , images = "ghcr.io/socialgouv/docker/${args.image_name}"
          , labels = Some
              ''
              org.opencontainers.image.title=${args.image_name}
              org.opencontainers.image.documentation=https://github.com/SocialGouv/docker/tree/''${{ github.sha }}/${args.image_name}
              ''
          , tags = Some
              ''
              type=sha
              type=raw,value=sha-''${{ github.sha }}
              type=ref,event=branch
              type=ref,event=pr
              type=semver,pattern={{version}}
              type=semver,pattern={{major}}.{{minor}}
              ''
          }

let __test__foo =
        assert
      :   socialgouv/docker-meta { image_name = "foo" }
        ≡ GithubActions.Step::{
          , uses = Some
              "crazy-max/ghaction-docker-meta@${ghaction-docker-meta.v3/sha}"
          , `with` = Some
            [ { mapKey = "labels"
              , mapValue =
                  ''
                  org.opencontainers.image.title=foo
                  org.opencontainers.image.documentation=https://github.com/SocialGouv/docker/tree/''${{ github.sha }}/foo
                  ''
              }
            , { mapKey = "tags"
              , mapValue =
                  ''
                  type=sha
                  type=raw,value=sha-''${{ github.sha }}
                  type=ref,event=branch
                  type=ref,event=pr
                  type=semver,pattern={{version}}
                  type=semver,pattern={{major}}.{{minor}}
                  ''
              }
            , { mapKey = "images", mapValue = "ghcr.io/socialgouv/docker/foo" }
            ]
          }

in  socialgouv/docker-meta
