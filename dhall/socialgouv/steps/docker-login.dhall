let GithubActions =
      ../../github-actions/package.dhall
        sha256:66b276bb67cca4cfcfd1027da45857cc8d53e75ea98433b15dade1e1e1ec22c8

let login-action =
      ../../steps/docker/login-action/package.dhall
        sha256:4649eb17a0aabf4898a100bf185efd0ce7c26026a89f0640811c98bbe5ae27e2

let socialgouv/docker-login =
          login-action.v1
            login-action.Input::{
            , password = Some "\${{ secrets.GHCR_REGISTRY_TOKEN }}"
            , registry = Some "ghcr.io"
            , username = Some "\${{ secrets.SOCIALGROOVYBOT_NAME }}"
            }
      //  { `if` = Some "\${{ github.event_name != 'pull_request' }}"
          , name = Some "Login to ghcr.io/socialgouv Registry"
          }

let __test__foo =
        assert
      :     socialgouv/docker-login
        ===  GithubActions.Step::{
             , `if` = Some "\${{ github.event_name != 'pull_request' }}"
             , name = Some "Login to ghcr.io/socialgouv Registry"
             , uses = Some "docker/login-action@${login-action.v1/sha}"
             , `with` = Some
               [ { mapKey = "password"
                 , mapValue = "\${{ secrets.GHCR_REGISTRY_TOKEN }}"
                 }
               , { mapKey = "registry", mapValue = "ghcr.io" }
               , { mapKey = "username"
                 , mapValue = "\${{ secrets.SOCIALGROOVYBOT_NAME }}"
                 }
               ]
             }

in  socialgouv/docker-login
