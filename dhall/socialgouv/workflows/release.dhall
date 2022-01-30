let GithubActions =
      ../../github-actions/package.dhall
        sha256:53da2310a2e009556455a73684b997c3bd53192637ac3c77562c30e3815f5f23

let Semantic =
      ../../github-actions/sementic.dhall
        sha256:a5cd5717e49b164e9a311ac3cd8ca8b59b0161b051acb981ff7779daf89a0f4a

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
