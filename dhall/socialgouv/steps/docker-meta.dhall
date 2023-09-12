let GithubActions =
      ../../github-actions/package.dhall
        sha256:66b276bb67cca4cfcfd1027da45857cc8d53e75ea98433b15dade1e1e1ec22c8

let ghaction-docker-meta =
      ../../steps/crazy-max/ghaction-docker-meta/package.dhall
        sha256:6c7a286a39a8272655c15e5d32f1edc731cf5e9ba2592242585d0653d04c32a0

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
