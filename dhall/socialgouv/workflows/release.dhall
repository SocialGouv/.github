let GithubActions =
      ../../github-actions/package.dhall
        sha256:0fab6df1dd1ec6e6d048d19951a5b7d195c3eb14723e24c25b7a40ff1433a02b

let Semantic =
      ../../github-actions/sementic.dhall
        sha256:d7a67d196bff4678df76483b6d9b41badee7c34170acc18a869a7a61154c7574

let name = "Release"

let release =
      GithubActions.Job::{
      , name = Some "Release"
      , runs-on = GithubActions.RunsOn.Type.ubuntu-latest
      , steps =
        [     GithubActions.steps.actions/checkout
          //  { name = Some "Checkout"
              , `with` = Some
                  (toMap { token = "\${{ secrets.SOCIALGROOVYBOT_BOTO_PAT }}" })
              }
        , GithubActions.Step::{
          , name = Some "Semantic Release"
          , uses = Some "cycjimmy/semantic-release-action@v2"
          , `with` = Some
              ( toMap
                  { extra_plugins =
                      ''
                        @semantic-release/changelog
                        @semantic-release/exec
                        @semantic-release/git
                      ''
                  }
              )
          , env = Some
              ( toMap
                  { GH_TOKEN = "\${{ secrets.GITHUB_TOKEN }}"
                  , GIT_AUTHOR_EMAIL = "\${{ secrets.SOCIALGROOVYBOT_EMAIL }}"
                  , GIT_AUTHOR_NAME = "\${{ secrets.SOCIALGROOVYBOT_NAME }}"
                  , GIT_COMMITTER_EMAIL =
                      "\${{ secrets.SOCIALGROOVYBOT_EMAIL }}"
                  , GIT_COMMITTER_NAME = "\${{ secrets.SOCIALGROOVYBOT_NAME }}"
                  , GITHUB_TOKEN = "\${{ secrets.GITHUB_TOKEN }}"
                  }
              )
          }
        ]
      }

in  GithubActions.Workflow::{
    , name
    , on = Semantic.OnReleaseBranches
    , jobs = toMap { release }
    }
