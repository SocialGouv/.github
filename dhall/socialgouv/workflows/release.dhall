let GithubActions =
      ../../github-actions/package.dhall
        sha256:689f05f7e4f9e6355b8ce935ca0568b1a1fdbbd746e0bc4e2e5d8f238cfa4358

let Semantic =
      ../../github-actions/sementic.dhall
        sha256:402a2ef29e19132e31351af07ee173644bc5066e2d0627172649afa0b4428c81

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
