let GithubActions =
      ../../github-actions/package.dhall sha256:2bbfa9dca70fcfb23b1382e737768a6447d766bcc4b8f2ef1141dd6b94cc5fee

let ghaction-docker-meta =
      ../../steps/crazy-max/ghaction-docker-meta/package.dhall sha256:23fdcc9226b0665b11e9a295b96d9abf991404142069a004b6f124fd0de2fc7a

let socialgouv/docker-meta =
      λ(args : { image_name : Text }) →
        ghaction-docker-meta.`v2.3.0`
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
              "crazy-max/ghaction-docker-meta@2e1a5c7fa42123697f82d479b551a1bbdb1bef88"
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
