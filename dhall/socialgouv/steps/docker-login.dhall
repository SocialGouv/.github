let GithubActions =
      ../../github-actions/package.dhall sha256:327d499ebf1ec63e5c3b0b0d5285b78a07be4ad1a941556eb35f67547004545f

let login-action =
      ../../steps/docker/login-action/package.dhall sha256:4265475c09a9d28a758ad4ac3f5e46131aa2c9463d8001b87bd52af21ffadc04

let socialgouv/docker-login =
          login-action.`v1.8.0`
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
             , uses = Some
                 "docker/login-action@f3364599c6aa293cdc2b8391b1b56d0c30e45c8a"
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
