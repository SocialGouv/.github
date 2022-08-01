let GithubActions =
      ../../github-actions/package.dhall
        sha256:0fab6df1dd1ec6e6d048d19951a5b7d195c3eb14723e24c25b7a40ff1433a02b

let ghaction-docker-meta =
      ../../steps/crazy-max/ghaction-docker-meta/package.dhall
        sha256:4d5b2f2d2baabe96699a6a4b72b45a3abeb41379274b7426734597bbfa2f39d8

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
